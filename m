Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CCF5812E5
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 14:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiGZMNZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiGZMNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 08:13:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7C2B258
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 05:13:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so19899511wrc.2
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=IFAx9Rc8a/SiekVW3zzrDYtqM2y65/VQNYg7O910RIk=;
        b=WMi9tx0hkxoEcpKiWf3pPET7AocSCr9MmYOx12cnsTdEw263xyr6VlW9K8qOYyQuZp
         ey7alBv2ojQTeV68v3GCM9ia3LKYWd6ji0Kfj3Vk8QHnl8kvH7O2J/ofJ8+qm3I1qT9I
         CZGgfoOnn5jjieXsb4zTF3tWkLmdhIkrnH60WrUr6Pit+DOx/uAHUlHDFEwMlOnsXMlz
         1UMXt3o9kpUSN9Srbm/xJdvdt2DxojAHSnZQf95CAq1OmYWKwzFcFt77Y3BG4nmFB9S5
         dmgNoorSWkvXil8gIXK5jyJe9FVaoKpeVDYmQSb4TZpordB1IgbGcbqKwCnSFZQm2M3Y
         pa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=IFAx9Rc8a/SiekVW3zzrDYtqM2y65/VQNYg7O910RIk=;
        b=eO6afjtSn1sNWK3m3Xgi4nbz9uGRgA6AiEMGoKO/oYg5VdoP+3aXGG8x8HU+RecEJD
         pDe0IK4KROcpfZEKgZEVC+YFzTPWyt/EBd1NFmeOwu7MwvyjFk13MXkQriZA+HF3Qz3R
         BYt/Krsy5No30gHvf/8EHSzzK+3psB8EP/KfwJr8pejOIK2hwlPN3iMaeYYhKWEwpk4h
         JFxBTaM5ELUAnkwEZDrzoi4mLIkKIyqR3/446au2ekx31dNcV2x+rsoeB9w5B85HF737
         dVrwGlhKjPhGwCsnrnOWCDSmBPOuR62OYd6txS8w602xtmPVTdGZHkpME3IMTReJ1pyS
         hv5g==
X-Gm-Message-State: AJIora84QrTylY47nhB/J2ZdQSp7lFSIc3pS8/QssSVkdPuMHn2KJ+ga
        Z0Q0Uh7CMRQz2S2YGEyKTpvvbYqohTU=
X-Google-Smtp-Source: AGRyM1thu2fgz5eh2lGRk9qvYJxE+rKhMVjkPj93avKrINM6IYSzHnp0EIpoqFRkedu1abDSTrOVnA==
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id n9-20020a5d5889000000b0021dbccd38e3mr10298532wrf.659.1658837599999;
        Tue, 26 Jul 2022 05:13:19 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003a2d6f26babsm18856018wms.3.2022.07.26.05.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:13:19 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Jul 2022 14:13:17 +0200
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Message-ID: <Yt/aXYiVmGKP282Q@krava>
References: <20220726051713.840431-1-kuifeng@fb.com>
 <20220726051713.840431-2-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726051713.840431-2-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 25, 2022 at 10:17:11PM -0700, Kui-Feng Lee wrote:
> Allow creating an iterator that loops through resources of one task/thread.
> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested
> in only the resources of a specific task or process.  Passing the
> additional parameters, people can now create an iterator to go
> through all resources or only the resources of a task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  include/linux/bpf.h            |  4 ++
>  include/uapi/linux/bpf.h       | 23 ++++++++++
>  kernel/bpf/task_iter.c         | 81 +++++++++++++++++++++++++---------
>  tools/include/uapi/linux/bpf.h | 23 ++++++++++
>  4 files changed, 109 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 11950029284f..c8d164404e20 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
>  
>  struct bpf_iter_aux_info {
>  	struct bpf_map *map;
> +	struct {
> +		__u32	tid;

should be just u32 ?

> +		u8	type;
> +	} task;
>  };
>  

SNIP

>  
>  /* BPF syscall commands, see bpf(2) man-page for more details. */
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 8c921799def4..7979aacb651e 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -12,6 +12,8 @@
>  
>  struct bpf_iter_seq_task_common {
>  	struct pid_namespace *ns;
> +	u32	tid;
> +	u8	type;
>  };
>  
>  struct bpf_iter_seq_task_info {
> @@ -22,18 +24,31 @@ struct bpf_iter_seq_task_info {
>  	u32 tid;
>  };
>  
> -static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
> +static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *common,
>  					     u32 *tid,
>  					     bool skip_if_dup_files)
>  {
>  	struct task_struct *task = NULL;
>  	struct pid *pid;
>  
> +	if (common->type == BPF_TASK_ITER_TID) {
> +		if (*tid)
> +			return NULL;

I tested and this condition breaks it for fd iterations, not sure about
the task and vma, because they share this function

if bpf_seq_read is called with small buffer there will be multiple calls
to task_file_seq_get_next and second one will stop in here, even if there
are more files to be displayed for the task in filter

it'd be nice to have some test for this ;-) or perhaps compare with the
not filtered output

SNIP

>  static const struct seq_operations task_seq_ops = {
>  	.start	= task_seq_start,
>  	.next	= task_seq_next,
> @@ -137,8 +166,7 @@ struct bpf_iter_seq_task_file_info {
>  static struct file *
>  task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>  {
> -	struct pid_namespace *ns = info->common.ns;
> -	u32 curr_tid = info->tid;
> +	u32 saved_tid = info->tid;
>  	struct task_struct *curr_task;
>  	unsigned int curr_fd = info->fd;
>  
> @@ -151,21 +179,18 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
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

nit, looks like we're missing proper indent in here


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

SNIP
