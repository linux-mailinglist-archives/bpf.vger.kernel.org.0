Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A559264C
	for <lists+bpf@lfdr.de>; Sun, 14 Aug 2022 22:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiHNUYq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Aug 2022 16:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNUYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 16:24:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A691E3F6
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 13:24:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j8so10519446ejx.9
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=8BlBJbQfYJBvlY7XIY1uOz9iiL65EVgLLYCmr4Ax/G4=;
        b=o2p9B9ZDMhE1JFMtXPlpe4kQkaV8bQlAr4aoN8MSmPKbj3WunZk0Rq1rfSo4OE03Qj
         tZURFFTQ1/nI4Dy9Cadg8mE93P0KIWeD9ODORU7IbZgJ+YyMsdVA0tsy/5fYpM8ZWj+w
         OTeKATsOtURbuJ37WsvQIBLNuMb7bcaW13iB05z8zZ3IP4oScF7IWbX8hS0AO1LilTKl
         616bNGmyciQ6XoD5HU/T/jkwGdeb6bHXVyBHsU4Uf37kckEUq3zGLOPiCJZYnFUOwaoG
         KGC1aXPnKmbLMpeV0bhvPWZTRtOV4et03PVQluikbBO+x//1CFlDSijMwAtSxVYj5C+h
         GCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=8BlBJbQfYJBvlY7XIY1uOz9iiL65EVgLLYCmr4Ax/G4=;
        b=jMbbvuoD8JWLYb1D7NzTrvtv0gj+wn6yLU5g6RUHJVxQaT2N1CK3qiTFoSEUizKOmb
         cNtP0v2ORIx8764oZ9lXnfStywzFcg2d5fqimCrvwCt0Cm7agWUTvUUCO6MHHhzCGU05
         RAcI4kxTWPNayy7YDnHAVCxjBCHIn+SI9w0Njr+/ccDPkOEshDTO1NXqiJUJq2Df578X
         2V9ypavaAEj6l1wby+LNHnZkUVz4pVw2yGnwcEZuJ+6tZGT+OA5KBwoFdLTFarKcNvtJ
         CfK9Irg5MzuA3qqSeD22gO22jr3u8DIp7cwRgwAKQw3rRYKUKZ6wSXefRfiQXKXmzzFf
         HaaA==
X-Gm-Message-State: ACgBeo1BhRxmyeVaNjJ1CNyHkWA+OuztG26u5Oaid6p6teTh+0bt5noh
        9skW3qfBC9m5+aEhoU/spPs=
X-Google-Smtp-Source: AA6agR6jTnoarE1qlIkje6xUB+mBviZnBsTBsr6n/N4vIIS3rulXOi37f2fl37+7C0jYCvRrTzbaRg==
X-Received: by 2002:a17:906:8a6c:b0:730:a322:6f69 with SMTP id hy12-20020a1709068a6c00b00730a3226f69mr8405641ejc.585.1660508681983;
        Sun, 14 Aug 2022 13:24:41 -0700 (PDT)
Received: from krava ([83.240.61.159])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b00730c3923a2csm3352456ejg.11.2022.08.14.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 13:24:41 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 14 Aug 2022 22:24:40 +0200
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
Message-ID: <YvlaCMB6DRIu1vjI@krava>
References: <20220811001654.1316689-1-kuifeng@fb.com>
 <20220811001654.1316689-2-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811001654.1316689-2-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 05:16:52PM -0700, Kui-Feng Lee wrote:

SNIP

> +static int bpf_iter_attach_task(struct bpf_prog *prog,
> +				union bpf_iter_link_info *linfo,
> +				struct bpf_iter_aux_info *aux)
> +{
> +	unsigned int flags;
> +	struct pid_namespace *ns;
> +	struct pid *pid;
> +	pid_t tgid;
> +
> +	if (linfo->task.tid != 0) {
> +		aux->task.type = BPF_TASK_ITER_TID;
> +		aux->task.tid = linfo->task.tid;
> +	} else if (linfo->task.tgid != 0) {
> +		aux->task.type = BPF_TASK_ITER_TGID;
> +		aux->task.tgid = linfo->task.tgid;
> +	} else if (linfo->task.pid_fd != 0) {
> +		aux->task.type = BPF_TASK_ITER_TGID;
> +		pid = pidfd_get_pid(linfo->task.pid_fd, &flags);
> +		if (IS_ERR(pid))
> +			return PTR_ERR(pid);
> +
> +		ns = task_active_pid_ns(current);
> +		if (IS_ERR(ns))
> +			return PTR_ERR(ns);
> +
> +		tgid = pid_nr_ns(pid, ns);
> +		if (tgid <= 0)
> +			return -EINVAL;
> +
> +		aux->task.tgid = tgid;
> +	} else {
> +		aux->task.type = BPF_TASK_ITER_ALL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct seq_operations task_seq_ops = {
>  	.start	= task_seq_start,
>  	.next	= task_seq_next,
> @@ -137,8 +198,7 @@ struct bpf_iter_seq_task_file_info {
>  static struct file *
>  task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>  {
> -	struct pid_namespace *ns = info->common.ns;
> -	u32 curr_tid = info->tid;
> +	u32 saved_tid = info->tid;

we use 'curr_' prefix for other stuff in the function, like
curr_task, curr_fd .. I think we should either change all of
them or actually keep curr_tid, which seem better to me

jirka

>  	struct task_struct *curr_task;
>  	unsigned int curr_fd = info->fd;
>  
> @@ -151,21 +211,18 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>  		curr_task = info->task;
>  		curr_fd = info->fd;
>  	} else {
> -                curr_task = task_seq_get_next(ns, &curr_tid, true);
> +		curr_task = task_seq_get_next(&info->common, &info->tid, true);
>                  if (!curr_task) {
>                          info->task = NULL;
> -                        info->tid = curr_tid;
>                          return NULL;
>                  }
>  
> -                /* set info->task and info->tid */
> +		/* set info->task */
>  		info->task = curr_task;
> -		if (curr_tid == info->tid) {
> +		if (saved_tid == info->tid)
>  			curr_fd = info->fd;
> -		} else {
> -			info->tid = curr_tid;
> +		else
>  			curr_fd = 0;
> -		}
>  	}
>  

SNIP
