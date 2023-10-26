Return-Path: <bpf+bounces-13336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A07D869E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124B8B20FE8
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FA381C9;
	Thu, 26 Oct 2023 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RtpCKVTI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC437C8A
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:21:51 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E171AD
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:21:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-408425c7c10so9071605e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698337307; x=1698942107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fvBEzVrnfm79WyUZYQB0CJ1riym2zqp8qSqeiGz6m4=;
        b=RtpCKVTIqVH8Ux7zzvuvh0RRH3u26Mei9eaqPTLN44Zmowbfxu7Sg1AxxlLjjHduZP
         R6VFW76CxvMzH+kbnkQCKlIT+zZ+CTgI9QxbVtQ7Tz/MzWOp4TDY5c11H/6DsZB7Dch6
         I1LiCJ4u1V3k9z6SmmG/U5fmTyhGOBcBuWLB85eNp++y0o6TyOGElMF9It4HsagyZ70x
         U2pr0LlsZoJewk+rqPXuGHqrBu90Rv57SHhpkg2Ou0Ww5PN4KxCGRTddOqObHZZ+9Ila
         ZHNIFXmZcd9YaBRiwrMNyBKfaxnK6kSksmiOepX32WyT2bV93unHoQ1nrL5/3W30IifZ
         kn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698337307; x=1698942107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fvBEzVrnfm79WyUZYQB0CJ1riym2zqp8qSqeiGz6m4=;
        b=K4xxgLTe7xf66l3wjrRys0Y+JS31KXGMGeVl449sVfvQtViPdHxb1vMsSI+EKRTKpN
         YMxHkpGtqEtIP1FTV7fMpGML/pFwKOSjEQswI/SZqvyKeKXSaEYoseazVf6a0gcGM3as
         +RRaVlGPYKiWtbgafrURc7AcNU4UuPTFcJcGxj1Z0gZbNCfmKndiVWBmJSxZwmpJ16GP
         3IMD+Jc6vNhsp4WPxn/vmR5dFS83j3c9PiBMaGK7Dk+0cd/ZVFs+eqBDv8ZKu3MI6wzA
         WwaMQjg5fnuv/EuTkZeGm0tbXCjTRl7G9d86hmaD5u0Jm8Y8ErcVmY+Kx82+CwefDgAX
         R3EA==
X-Gm-Message-State: AOJu0YwKv87c6GKunp/TbR0ALFwwe11FdQsN4Dc72r9x00MvsKXgCs3P
	0h/rbQY5nXPtx7uiR3enJPduYQ==
X-Google-Smtp-Source: AGHT+IF+sJ5wwBfp70PO4gBJbjiIslD4ysYiWml6Ch1uM7hwLCQRF+ppANqnTGKolwNCD5bP3sM/2A==
X-Received: by 2002:a05:600c:4f55:b0:408:3707:b199 with SMTP id m21-20020a05600c4f5500b004083707b199mr248925wmq.3.1698337306682;
        Thu, 26 Oct 2023 09:21:46 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b0040586360a36sm2911925wmr.17.2023.10.26.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:21:46 -0700 (PDT)
Date: Thu, 26 Oct 2023 18:21:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
	andrii@kernel.org, john.fastabend@gmail.com, andrew@lunn.ch,
	toke@kernel.org, toke@redhat.com, sdf@google.com,
	daniel@iogearbox.net, idosch@idosch.org
Subject: Re: [PATCH bpf-next v2] netkit: use netlink policy for mode and
 policy attributes validation
Message-ID: <ZTqSGOAjB+SHc9CJ@nanopsycho>
References: <20231026151659.1676037-1-razor@blackwall.org>
 <20231026084351.6bb4ba8a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026084351.6bb4ba8a@kernel.org>

Thu, Oct 26, 2023 at 05:43:51PM CEST, kuba@kernel.org wrote:
>On Thu, 26 Oct 2023 18:16:59 +0300 Nikolay Aleksandrov wrote:
>>  static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>>  	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
>> -	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
>> -	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
>> -	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
>> +	[IFLA_NETKIT_POLICY]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
>> +								 netkit_check_policy,
>> +								 sizeof(u32)),
>> +	[IFLA_NETKIT_MODE]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
>> +								 netkit_check_mode,
>> +								 sizeof(u32)),
>> +	[IFLA_NETKIT_PEER_POLICY]	= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
>> +								 netkit_check_policy,
>> +								 sizeof(u32)),
>
>I vote to leave this code be. It's not perfect. But typing it as binary
>is not getting us closer to perfection.

Yeah :/

