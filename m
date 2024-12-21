Return-Path: <bpf+bounces-47514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF1D9F9F01
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 08:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B827A0310
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3E1E9B30;
	Sat, 21 Dec 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6A3bOwt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973D6F06B
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765560; cv=none; b=Zsq7NvkAwn3G2vh8iWM7Pq9oR4w9j8kYOgiNk6FqAM7j9Y/9xyZnBHbsFrb1MBfRv4TeOK0rGduTGBSSgkhH6ItgrNFuS8ezCR+oineTjtqaGDQirWSVkwEPrVHAY15yB8ZX1YCc5WSXbqracaEKbmfQlFzeLN6nNv14kccZI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765560; c=relaxed/simple;
	bh=I1/z8oZ8K4qrMUsURPMPFmVzrNbhIEQVWHlj8P52i1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkrbXBtyTuXBgy6FaaAoLYaHX2sbikAsflNuBcdoJ/7wPCAGlPOQ9cJ3xI8ARzwisajd7D7Yb3cHgtXAGhGx4ZwnKcJkfuScfoGt5sKXPYxXnAIb48UNk6OF2KPA4uXfLOAPZwbWybG/lojG11693waVG0U9r40YXbUEE80tOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6A3bOwt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2155c25e9a4so204765ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 23:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734765558; x=1735370358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdncTDn1PyOUgZbZIvUaofh0len8ANMsS39wRNf6cPc=;
        b=b6A3bOwt8syLWIeKlHycJiOysEBqZAwnBnsrvU5cV6EpM6zaCY6IJaFVUKJngtd0Uw
         RgCb6M4Mb1JwNae7HGdyO8h6M1xOGKAyircRpLVnCecVPD6391GPJX4Oc4e19UfPux2v
         NOxI0heCWuo6erSENSd7QgqTHb4XdlnuY2K3mIqOg7nnn6PU/FFFELzUn2+xrm3so3Qj
         GLRlN+TmQwc3/eOCgxb1TglWoLF1eBW8fgRPkGLET6cpx4TG62pGDAHwJlb5NbixL5QG
         ggrbPtcaEUeAeqbc0OGcAQlbYUv8tPR8/dAZS6odLC5KvhMi8Pk7o8YD4N9b3jPl8p5v
         aeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765558; x=1735370358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdncTDn1PyOUgZbZIvUaofh0len8ANMsS39wRNf6cPc=;
        b=LD6qF6cRSbAR+aFPo/5OhayFroRMS9NFxJMVVYW94eotbW2Q3rjel3ONNZYusSjURY
         VTkZgEOj3mE/cfx+Pmpl5OXwgK274LTBpqLQpqIDR2GIZYqqpjRHxzj6WvDZc1abBepW
         SrjyJUrwrXUpBjLuhSz+oqM8Ob/4an99wfO/nRTzYUDQo9FdQjl7cky97nxpiztvOB7j
         PUdDKUYbgB5wCQSGMp2LEilIt3aDySl+db2gQK+8LxZj5rtERTi7lM75FjMUcJMzQRM0
         22clgetauJCpSyzdQeuwQs3hrU+UWWVfUizrBZrP2MdWU3iizKifCts38PSXiYdXxiFQ
         yDAw==
X-Gm-Message-State: AOJu0YzKJ+ZNNx5g25U0QuXiIvpGaQf5Ze/qmmVqcMDQs2Xz5B912Uti
	VtfzXqE8GzUfTHmedEtd7wJ0HY0i2/nR7FGZTpXY2qQc9wuqizbZRfGiWVhCHcGbGCW+B6NVU8D
	fAQ2J
X-Gm-Gg: ASbGncs0NOJzHTIN84BNjVul2/dN0pyDApLEy6gATwI+q2zwMJ/wGIU9unZwyzXbsK+
	8YEUXQ+me20ioOT2tmbQ1jjf0Um8BgolBQjERA0zcUoK4LNeO4pygiR0AH0iLkjBS3uTcIRWOuu
	N0qjC2g7XT5gQ05CFsJv7IBPu+h+UTFBJg9o0pQz+kWpI0TL5p/328Db4GZ6O68JroFM4HNfibM
	JLXKr/0SIcrfvk86w1Yci8J3n3oXR102vj0Kqp9vuyH4nYnBEQoI6zlOfF80WSFmvUSpN6/4oZs
	VZqlcOyAC7jNLPbqK2k=
X-Google-Smtp-Source: AGHT+IEgiPFIzblCXKV+/Ib5ixxl5WSIHVFk7MrQDNdUa8BgMF1P1wzo+9+hTRw9a6eDX99Z3N4Guw==
X-Received: by 2002:a17:902:ea08:b0:216:201e:1b4c with SMTP id d9443c01a7336-219e770dcc4mr3208095ad.9.1734765557479;
        Fri, 20 Dec 2024 23:19:17 -0800 (PST)
Received: from google.com (40.155.125.34.bc.googleusercontent.com. [34.125.155.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb42sm4185783b3a.115.2024.12.20.23.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 23:19:17 -0800 (PST)
Date: Sat, 21 Dec 2024 07:19:13 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 0/4] Introduce load-acquire and
 store-release BPF instructions
Message-ID: <Z2Zr8ZdKiM-5QUMp@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734742802.git.yepeilin@google.com>

By this:

On Sat, Dec 21, 2024 at 01:22:04AM +0000, Peilin Ye wrote:
> Based on [3], the BPF load-acquire, the arm64 JIT compiler generates LDAR
> (RCsc) instead of LDAPR (RCpc).

I actually meant:

  Based on [3], for BPF load-acquire, make the arm64 JIT compiler
  generate LDAR (RCsc) instead of LDAPR (RCpc).

Sorry for any confusion.


