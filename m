Return-Path: <bpf+bounces-15518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C247F2BCA
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433C71C2187B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E374879C;
	Tue, 21 Nov 2023 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHRwg3N9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEFC9C
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 03:35:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548d67d30bbso2455821a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 03:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700566514; x=1701171314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jC83yH4Ec2LAPXlxkBLEfmhva5kFA6UMwcMYYO8/Xuk=;
        b=PHRwg3N9J9p3AsFtuQ/nzscZkOZJIS8yb1M+txkdK5XkJLpA5Ak/UojL9Rs+c95OxW
         GsVBl3bsJhdLaCeWKq3zlXqOx+KWm/z8y57ltjo8Q8xtp492ugyl/zK6ELB9i4gR+lKR
         CirILBljwx78/qB5UGhm2zb369SFJP/9yGwtNPPsdqkEFBbFasT1sso9CFqufueWRBj2
         tz+50hRtKXu4dFzhDOznPryUQX44665gXuuM3IriNUWUuoyjl0t+JCFJgNnBuwTk4jp+
         2htOBM8w0MEKuPKu9nrpkVLtS8fpRWEti+7re3wTVFyWfR301KmJ7W7smsr4V6g9+P0e
         I8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700566514; x=1701171314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC83yH4Ec2LAPXlxkBLEfmhva5kFA6UMwcMYYO8/Xuk=;
        b=jk/lu7vA4cVGDzCy1Sw6Zi2DFlrRKyKVca/YYS2z8PMuWw1sv1Rtz32SFHXXe7a51j
         GOpmzHbmwnY97zhgrdAo9ym05lV5i6heF4E0rVtfd1iJdx9uAP1atXVhfUycc7lmjiYm
         6heg1iLR/5thr+xS+lCUV9PGvoThs7EYb9XEWoFdCN7QkS4WgFxh11At0jotqqkUvirK
         iRMU+uebF4Cq37P6oOG/tV1u4a+sOaVmjp0w3jIIj5Qkp9EUc09sS2wQsVD6a6cC76G9
         8nTbAytFooBN2vsVt5kJ4avWdNoxLUC1joEq9zaFrAlYBMGgczSOqJJamcGSg01FU5QF
         Zj2g==
X-Gm-Message-State: AOJu0YzdEz0QTqvGKHt9QvkTHQUKqpQkzuhqYbX0Kt/lUvlyNO11qioJ
	xpp5bS6K3x4xc5RcFcVoqxI=
X-Google-Smtp-Source: AGHT+IEqB0yWxKac1SHs+vYo5GOni++KO+Xxqeyomwq2xaARjQYbmksqglXE9LLhZ9uCPW7TFHgjgw==
X-Received: by 2002:a05:6402:1353:b0:547:65f0:bac with SMTP id y19-20020a056402135300b0054765f00bacmr1461280edw.42.1700566513832;
        Tue, 21 Nov 2023 03:35:13 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id y24-20020aa7d518000000b005402c456892sm4789010edq.33.2023.11.21.03.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:35:13 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Nov 2023 12:35:12 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCHv3 bpf-next 6/6] bpftool: Add support to display
 uprobe_multi links
Message-ID: <ZVyV8JW29oXAKAlR@krava>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-7-jolsa@kernel.org>
 <769b00a5-88ac-4902-a69e-01ec977338ee@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769b00a5-88ac-4902-a69e-01ec977338ee@linux.dev>

On Mon, Nov 20, 2023 at 10:32:02AM -0800, Yonghong Song wrote:

SNIP

> > +static void show_uprobe_multi_plain(struct bpf_link_info *info)
> > +{
> > +	__u32 i;
> > +
> > +	if (!info->uprobe_multi.count)
> > +		return;
> > +
> > +	if (info->uprobe_multi.flags & BPF_F_UPROBE_MULTI_RETURN)
> > +		printf("\n\turetprobe.multi  ");
> > +	else
> > +		printf("\n\tuprobe.multi  ");
> > +
> > +	printf("path %s  ", (char *) u64_to_ptr(info->uprobe_multi.path));
> > +	printf("func_cnt %u  ", info->uprobe_multi.count);
> > +
> > +	if (info->uprobe_multi.pid != (__u32) -1)
> > +		printf("pid %d  ", info->uprobe_multi.pid);
> 
> Could you explain when info->uprobe_multi.pid could be -1?
> From patch 3, I see:
> 	info->uprobe_multi.pid = umulti_link->task ?
> 			 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
> and cannot find how -1 could be assigned to info->uprobe_multi.pid.

ah it's leftover from previous version fix.. and I forgot to update
the bpftool code.. nice catch, thanks

jirka

> 
> > +
> > +	printf("\n\t%-16s   %-16s   %-16s", "offset", "ref_ctr_offset", "cookies");
> > +	for (i = 0; i < info->uprobe_multi.count; i++) {
> > +		printf("\n\t0x%-16llx 0x%-16llx 0x%-16llx",
> > +			u64_to_arr(info->uprobe_multi.offsets)[i],
> > +			u64_to_arr(info->uprobe_multi.ref_ctr_offsets)[i],
> > +			u64_to_arr(info->uprobe_multi.cookies)[i]);
> > +	}
> > +}
> > +
> >   static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> >   {
> >   	const char *buf;
> > [...]

