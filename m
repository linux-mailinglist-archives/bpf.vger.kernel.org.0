Return-Path: <bpf+bounces-4735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2205B74E9AF
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0B32815A9
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5034517735;
	Tue, 11 Jul 2023 09:01:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD8174C0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:01:36 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35810E3
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:01:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso2593802a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066090; x=1691658090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpAdSnyq7NRLQB98sI+EeEhhKvyY+sxtrDRFlAgaNRI=;
        b=pHlJbvxmxMpI7kLx//MdwZb5YeIkRwAnas0q5XS8dVcuUtdWrUKCG9YFWIjgHpRtUG
         1OmB+Qje5MbA2dWvYBF4Up01DesyzoossVrHFNX3pYawPO44O581HZn3G+H967WBhVfM
         tIoLarcyWEWnjlxQWDE453YvER8cWTEqgiUIscuwDaxdPf0tvsp87h8lQ2/hH8sufq5z
         nGz/mixkMzQ2moDrMafbj4g4DbZeJqjEeXb/ZcHKpLBTc5sgapmHRmV1FWqbHt755S1d
         gaYmEHy3IGbtin1MK+KDQun59XHWpbUPnKjgNedPKGD46Q6uB+XqSmx2Ei9Z+0dBYrT1
         EWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066090; x=1691658090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpAdSnyq7NRLQB98sI+EeEhhKvyY+sxtrDRFlAgaNRI=;
        b=gmk08TizEGt/STc/6J5C/kZX/CVjMyoX8dPIYsrRYdKblKKXhUikX9K7rsYijcH/J7
         /yNjvJXXlUgRhXOecau1N/gpsOLgZraMs9yxi5fQOmW5Ti7E/N7hX9eovm9nf0rmKmUA
         7Qbnhzpj+vspAHy3uG3jhVZE1xYL7JkmIUAnGdiL8z8vr6xIRIkCCZik9IRi6UGtlpUT
         eciBCpJnZvAeL5DdAYcQqsAHKlI5Aiq152c4ugHnMojqgXPyOLUhvSiekRqtcqIuNBhp
         kZcXLO6+h919sync+1nALmLQjM9ASLfidt6oKqksXxFSUF6A775lXO6oy+abmyOZjqDy
         2Y0Q==
X-Gm-Message-State: ABy/qLYHvB+E56HKH6uvoqCGp7O5vo1LI0hufsNhqQuLPk+DM71SLfId
	jzmEBIt3miwkhydM2M1s/nM=
X-Google-Smtp-Source: APBJJlFX16T+qMn3DoGaLuK9BgRmAUsV4L/sQpg/0h4hUeqFtrKRMI/ODcwSIzh5S7tACamMD9VCJg==
X-Received: by 2002:a50:e606:0:b0:51e:d96:15e4 with SMTP id y6-20020a50e606000000b0051e0d9615e4mr14876503edm.19.1689066090108;
        Tue, 11 Jul 2023 02:01:30 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id d18-20020aa7ce12000000b0051ddfb4385asm935167edv.45.2023.07.11.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:01:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:01:26 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 02/26] bpf: Add multi uprobe link
Message-ID: <ZK0aZtiGZlUDzuwv@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-3-jolsa@kernel.org>
 <CAEf4BzbxuCRmk3fTkpAM0=GPJErKQq-FezqGEf05zueFcWJa6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbxuCRmk3fTkpAM0=GPJErKQq-FezqGEf05zueFcWJa6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:22:29PM -0700, Andrii Nakryiko wrote:

SNIP

> > +       flags = attr->link_create.uprobe_multi.flags;
> > +       if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * path, offsets and cnt are mandatory,
> > +        * ref_ctr_offsets is optional
> > +        */
> > +       upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> > +       uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
> > +       cnt = attr->link_create.uprobe_multi.cnt;
> > +
> > +       if (!upath || !uoffsets || !cnt)
> > +               return -EINVAL;
> 
> see below for -EBADF, but we can also, additionally, return -EPROTO
> here, for example?
> 
> > +
> > +       uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
> > +
> > +       name = strndup_user(upath, PATH_MAX);
> > +       if (IS_ERR(name)) {
> > +               err = PTR_ERR(name);
> > +               return err;
> > +       }
> > +
> > +       err = kern_path(name, LOOKUP_FOLLOW, &path);
> > +       kfree(name);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!d_is_reg(path.dentry)) {
> > +               err = -EINVAL;
> 
> as I mentioned in another patch, -EBADF here for feature detection
> (and it makes sense by itself, probably)

yes, I like this place better, also -EBADF error makes more sense in here

thanks,
jirka

> 
> > +               goto error_path_put;
> > +       }
> > +
> > +       err = -ENOMEM;
> > +
> > +       link = kzalloc(sizeof(*link), GFP_KERNEL);
> > +       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> > +
> > +       if (!uprobes || !link)
> > +               goto error_free;
> > +
> > +       if (uref_ctr_offsets) {
> > +               ref_ctr_offsets = kvcalloc(cnt, sizeof(*ref_ctr_offsets), GFP_KERNEL);
> > +               if (!ref_ctr_offsets)
> > +                       goto error_free;
> > +       }
> > +
> 
> [...]

