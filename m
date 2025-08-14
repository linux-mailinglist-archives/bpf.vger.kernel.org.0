Return-Path: <bpf+bounces-65615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706EB25DFA
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF65720327
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D782857C2;
	Thu, 14 Aug 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6VgBr1/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EA28D8F4
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157524; cv=none; b=OKBf8CJvqyj8ZvH+ZUsBoVLmbRN2Vk5aW/UzJxrPIC9vSMNjp6yaQHGX2REczxNqVi8aQNyS2VMZyX9pmgUu7v9xdtxi/SzS8j1kE+CBFRsdrsuT8mzD6g2UzggSF0eF/dvjcadJMCXJzr9ge596k6HxdjXFOWuFpyyT6P7Zyqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157524; c=relaxed/simple;
	bh=KSWLnoTBOlNzYx5x5XVZJ7YKJEDG7DMm3pzboACqSU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eVxXYr6R3sS4Fo4A9/O2cIeOywgLFelHfDOx9nYTY8RoC1EaoYQiekKhP3x/Rc717wfOuSAnR5YldkC4MVJ+7cAwAVZLpYjp92yc+fIjdQrY5Jg3vTa2PQRjtF/ej30mPyI6RI0bHxf2lxBo4xFOWGYhhTQt1g4LQJ1gDMrM0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6VgBr1/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755157522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh3fAUzpnwErAtwtO1rLAD+DknqFNguq3c79rP/CRi8=;
	b=J6VgBr1/V9v0l4omZcuG3BNDnZXBHagQiMsXrO7f9yQFfUyQE/6rcYviNBDqdrk0ZfZZqD
	dD2ZG2psrhsy2Jf/e4KzoSjSRMe25nPBhTWVW40IwtWvu+5sbtJCBsSi6BYRPVHoRNpr3u
	3TrkzZuNv9QnN1BlrhaDXMeotfR8474=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-f_whSis0NSSHfPp8KXBsDw-1; Thu, 14 Aug 2025 03:45:20 -0400
X-MC-Unique: f_whSis0NSSHfPp8KXBsDw-1
X-Mimecast-MFC-AGG-ID: f_whSis0NSSHfPp8KXBsDw_1755157520
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a928da763so14989116d6.2
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 00:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755157520; x=1755762320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh3fAUzpnwErAtwtO1rLAD+DknqFNguq3c79rP/CRi8=;
        b=nnBJnv5ZYWOAoUfZ1MBG3fsGai51h2BFqECjGqjCcx7hzLPzI/FO6gWoZsTb7fED+Z
         fBVd+ifX8o3xJ6lhgPztbWHnC4lVaN85Jd+Xtz70GEsS/IXKkd7eOUULhVFlR/WydE3z
         nRCXAZ2EePmCigwQdMkKb12IrA/xaFsKqMtXSoOe+etvQ6B7kEbgQWX7/uIsC/+VjJiG
         mIn4sBhJfBA+c5ZGR7ObJCat1Pqzkbqmx4Xevro5jWJION1CEL6cL44VF/5ALAhSyzVJ
         KWCUAjTrbcoINH6sN8yeVp/DQKYe4ZSrgm2eChLS8uz1c4OZ3k07wDA1HyP5Xh7xS2jy
         ge6w==
X-Forwarded-Encrypted: i=1; AJvYcCXt9UYwlrig0nlzU7z2Zs5ib6R2D3A97PZ7kVdevb8SWzwpadMGEopLslKWgnHquHJqt7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNR5BFaBgjOPJvu7T4kK6uTsYX/dnQNSua7C/PgmQSFlgKFpJx
	eC18nRpfHF1i9GGULJoVImrTX3unkOkl3MJLIXhrZx3WyUT+j8gIOH3CSNm85kSTz71IeohJycg
	Dpdk10ARK85oXFBTtsxHbPftuhENlZj4k1GHXPoohEoKdwuzVmTx1UQ==
X-Gm-Gg: ASbGnctVpfOdW236J1HLMH/lyWJD1drZ5rHWTdqOSF6Q7y/oJnjLWumy/r5E4YlvkID
	RgSlvsZbjb4So6P8UjH9DTnbt24RaQYPPbDeSEhtXuYGFnJ9N1vBcoqCGYbT/zfD4DpoREU7ggt
	fJOB9M/nbxPOSrG/wBgdR+s2EUH2mql9cvP3rfU3lWw2ceSVBJ/aHwTSu6mD5mrVnEe1amZ5HLI
	2/Jafn51/eFsI3H77UpVjWdsuzgi8rxrG+opL5DrV+by5ofRdJzKaQRbXAY4tvMN80vxJY9+euP
	9FpzH+XZEcuxBfHX9uEmfYvB/gT+OhUFNtcOl9SBKmACxrGDRN7L7FtoHkq91ckoAUq+DDUqaCW
	oQYX9tGbR7Ck=
X-Received: by 2002:a05:6214:2aa5:b0:704:7fda:d174 with SMTP id 6a1803df08f44-70af1cf09bemr31867696d6.2.1755157519986;
        Thu, 14 Aug 2025 00:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW6lRrp4NlQG1ZkIRQnCbAccBSIpsmnxNsHLJGiUzBCfXvnS33GU0a29KgbaqXmSBQXEvaOA==
X-Received: by 2002:a05:6214:2aa5:b0:704:7fda:d174 with SMTP id 6a1803df08f44-70af1cf09bemr31867416d6.2.1755157519405;
        Thu, 14 Aug 2025 00:45:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b0692csm9715536d6.46.2025.08.14.00.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 00:45:18 -0700 (PDT)
Message-ID: <274729ea-8db3-41e4-9dfa-f33e5e65222b@redhat.com>
Date: Thu, 14 Aug 2025 09:45:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 00/14] AccECN protocol patch series
To: "Livingood, Jason" <Jason_Livingood@comcast.com>,
 "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dave Taht <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <BL0PR11MB29614F8BE9B66484A478F6F4C72AA@BL0PR11MB2961.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <BL0PR11MB29614F8BE9B66484A478F6F4C72AA@BL0PR11MB2961.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/25 5:43 PM, Livingood, Jason wrote:
> Hi Paolo – If this patch series is delayed to the next release cycle,
> what release number would that be and – more critically – what would the
> timing be? 

See:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#git-trees-and-patch-flow

net-next is open now. Patch need to be re-submitted and will be
processed with the usual timing.

Thanks,

Paolo


