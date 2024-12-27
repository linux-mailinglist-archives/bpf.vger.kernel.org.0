Return-Path: <bpf+bounces-47654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285B9FD283
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FA5163AFE
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A17155741;
	Fri, 27 Dec 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8Y6BiNL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE998139597
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735291220; cv=none; b=cdkW5s77eJdL9FZ0I3KSGAatHvSZUe+PcCvVnQBcmvLV3S9cwe3341Q2tSHSv46HEUc5Rj1chzbXFe5x7KdlGkFyM11zmxh9Rglwr1qsSV+hGJq0cE4GBOKZdPzB8Brb3PgkPj30KRKMoI2UIIV/P8BsBqgFRQLokqUkMQlxqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735291220; c=relaxed/simple;
	bh=Y3fh0ce3Zu8u22azo60MsnTDQj8MqDTK+3uZANqZ8Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXc4SIzq8btLzqjVV1SeowuCK4XhQUBAVdDPyQHbf9+pDg1e1DHA9cEzeJ1ctG75FLjcUz4jAW8xl6uShNZYDv8HQzdeCxc1PaCatYMHgZMX017qreZCTX0XxWmoub27WzUBhXD2uHoYfBgHAtqU8L3LMNiUDumM5Thx4K/ttbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8Y6BiNL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f6ca9a81so564905ad.1
        for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 01:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735291218; x=1735896018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jibWnOynvj6Tts5K4/dFPRmc8WUjCemc/7h1jj7PBSk=;
        b=V8Y6BiNLskci145oVKqgf01EbyDFNYP8jLAPiiHXSRQEPK/UMagz41Q4WGS+R73zk3
         Wm1rBTi3vTcvCmjQe2aGI4hZKytA4xZtO5AVUZiPxHPbNnehYNdYtkfI8nqi7OP1RG2n
         aifkFbkyebgH0/vCPariSvLnn4bLIi2MV9pwceo5hhH5VUMbztOzAfDqxYc0AC0QE0eY
         BUEGmiId8uQNctWcTHrQsAuM/Os+KjvI4E4tOyvDoT49RBOw55rHYmbldkIpEfX7muy0
         oADelPhBq75h0E239PcIyfU96pHbmHe3w4updSs94qWlsnmez5Hf5hPOQ8/e0S5JDcNg
         ZubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735291218; x=1735896018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jibWnOynvj6Tts5K4/dFPRmc8WUjCemc/7h1jj7PBSk=;
        b=DpnCd0o/zksJcsPviajhqKM1RzM+PZ1t9lMim3gkTr4IDsOmZF087HgJu53EuJfNfA
         BcY3XnUt0krifqGOotfP3a2HJ4Nd32JTrhtvl0WXh6iX1NgVjpayObYLQTQimMiwKSur
         5d2lh2xtMh1yBlilHbJDs2HjlyITDPzaAZ2/90GDvNJ9sa5YEr7wNQxOX9qKab0KybAd
         ke1VFiJPEzeRkWuS4Q22aG3wE+RBNd6hSQdRhxiCRDBXq+uUpyXmbsRNQZ4HZJiDrAgU
         FhTyWzjNKP3Q9RvIyXuqasr6iO1y4v+tRB3F3lgwoNiv8hdDtKRKyVXXbIMmD7PFbxqQ
         a+pw==
X-Gm-Message-State: AOJu0YyaYqcKj67NlZ6jrgbeyj62pf0oGzRb7qaRf2+C+m+HIbXiXQGu
	sIv0zTq3pTDmIpwsWTPIOOoueA22MdZ+GjmorlFIDho5Y2JHm6InNscaDwqF6w==
X-Gm-Gg: ASbGncuSb/YJgRoCFphX0L4RKR8iTAKngJYty7/BuRK8aVl5Ub1ZUkVTEJef4g1/vAi
	IYp1iRzx09Vs0LSDv80EktBdU8BLiZ0emaRi2yoqgqKCTAt4tMo6qPNVs/il5zgA+YS1nmlpyyU
	Pn3pce7H8i4FZiBX83g7t1v6YdcHPHDVziMYcDT17hCkdVzFhkYYUCrE+CY9Vum3x+VD8tP43qm
	v/5dYla5xCIy54PVHsOK4brdVtgwPANvIm2+f5GjoiWR62jq9PbpKmS/ZtN27/XB68AFJdId/3Z
	85G/WS0IvsjXY9ao+lA=
X-Google-Smtp-Source: AGHT+IEdsphK+fVkaZEclFM1m1g2bZVGWULWpmqPpb2/1q/5JxKqhRKT83SWoqbybovy+11JysBZEw==
X-Received: by 2002:a17:902:c407:b0:215:b077:5c21 with SMTP id d9443c01a7336-219e68f5a3fmr11653385ad.26.1735291217912;
        Fri, 27 Dec 2024 01:20:17 -0800 (PST)
Received: from google.com (40.155.125.34.bc.googleusercontent.com. [34.125.155.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed644d87sm18925077a91.27.2024.12.27.01.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 01:20:16 -0800 (PST)
Date: Fri, 27 Dec 2024 09:20:12 +0000
From: Peilin Ye <yepeilin@google.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z25xTKrgR0j6U3qA@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
 <f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com>
 <Z23hntYzWuZOnScP@google.com>
 <Z23zes0fA3KGABcN@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z23zes0fA3KGABcN@google.com>

On Fri, Dec 27, 2024 at 12:23:22AM +0000, Peilin Ye wrote:
>         if (off) {
> -               emit_a64_mov_i(true, tmp, off, ctx);
> -               emit(A64_ADD(true, tmp, tmp, ptr), ctx);
> -               ptr = tmp;
> +               if (is_addsub_imm(off)) {
> +                       emit(A64_ADD_I(true, ptr, ptr, off), ctx);
                                               ~~~

> +               } else if (is_addsub_imm(-off)) {
> +                       emit(A64_SUB_I(true, ptr, ptr, -off), ctx);
                                               ~~~

No, I must not write to the 'ptr' register here.

> +               } else {
> +                       emit_a64_mov_i(true, tmp, off, ctx);
> +                       emit(A64_ADD(true, tmp, tmp, ptr), ctx);
> +                       ptr = tmp;
> +               }
>         }

I will do this instead:

--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -658,8 +658,14 @@ static int emit_atomic_load_store(const struct bpf_insn *insn, struct jit_ctx *c
                ptr = dst;

        if (off) {
-               emit_a64_mov_i(true, tmp, off, ctx);
-               emit(A64_ADD(true, tmp, tmp, ptr), ctx);
+               if (is_addsub_imm(off)) {
+                       emit(A64_ADD_I(true, tmp, ptr, off), ctx);
+               } else if (is_addsub_imm(-off)) {
+                       emit(A64_SUB_I(true, tmp, ptr, -off), ctx);
+               } else {
+                       emit_a64_mov_i(true, tmp, off, ctx);
+                       emit(A64_ADD(true, tmp, tmp, ptr), ctx);
+               }
                ptr = tmp;
        }
        if (arena) {

Thanks,
Peilin Ye


