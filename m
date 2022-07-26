Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4458140C
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiGZNTK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGZNTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 09:19:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7B2C11B
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:19:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v13so12341216wru.12
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=eVDIVQCALnjlSpuz0j5veZmdagPWnkWWr0aR3qWAwCE=;
        b=naXPo09jv/hBbPu5SBJL74qLKNp/8TOTtb8jj765YYsxr6G2PRtX8owV+vZWt1pBc+
         kSF7t3o1aScUtRYX7D6LH4pdTnm6hGUp2OIgqcwB2sK6JpZmQtw7bbgljjnPmDPO9AkY
         S5mqzCOQL0CjdWkybjZDf8VlZsI0K9e0CSzvUtvSJNRRffQCJJxeym2nW3w5TGzh+uCh
         3yMJcE/oXDcXip8ruq/w88bu2ZtdBPGPCQB9uuYLqnfaDc0QKDhGbHINRpDGeCOazNl1
         2GshpsxdqleMxDvPmtrzh8J+w8ZKDULkDkO34QEpu4LNKsOZPJ/8QuvhCrWo/wMTA5Pn
         INWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=eVDIVQCALnjlSpuz0j5veZmdagPWnkWWr0aR3qWAwCE=;
        b=g+eqUo5GyFRRSoMCU6DfpqsfiF60oAEtkKO7fUpqLsPvhMpSckRK9AYp0Hrz4q3yhW
         56Q6uBncfFdOO9vNULB5qGIl0+36gqnTXg0LSvJtahx/NkiT1zMx5QfhZ/HN4jLgppHu
         rSKAMy01uIF1VU3495+ISFEyjEURBJA0VBEI6tO3ENELcWzKdyxzER+rHbku0COpmF3s
         JWCuK0caEwcAjDVp+Bp51/DHiuAUttrR1exGvnrjvaKpMuIDARn/LFMqbemOmwzMau+H
         xiAh5lIqUiwBYTEm4UgvaKJ/hTDn1jC3OFJMrGIhX+qoGk6bS8eTUzL4Jo9rF+f9eo4j
         qJ+w==
X-Gm-Message-State: AJIora9/YgXraph7W41iO6nGugf/nZmFMUVrW+VzyIFHx9tOaBvH1exS
        83AlFwUcPGQ2g1xrmW4gLTY=
X-Google-Smtp-Source: AGRyM1uD2eA53deo7Tyv7yna6XQFqwAqwdg2lFaG1s6eWRpTyR4LpABhRDfFyG/9rKa+Tkcbyy2/ng==
X-Received: by 2002:a5d:4903:0:b0:21d:6d8f:a321 with SMTP id x3-20020a5d4903000000b0021d6d8fa321mr10865672wrq.59.1658841546604;
        Tue, 26 Jul 2022 06:19:06 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id c25-20020a7bc859000000b003a0375c4f73sm17701617wml.44.2022.07.26.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:19:06 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Jul 2022 15:19:04 +0200
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
        yhs@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Message-ID: <Yt/pyDUuvS1rwlpc@krava>
References: <20220726051713.840431-1-kuifeng@fb.com>
 <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/aXYiVmGKP282Q@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 26, 2022 at 02:13:17PM +0200, Jiri Olsa wrote:
> On Mon, Jul 25, 2022 at 10:17:11PM -0700, Kui-Feng Lee wrote:
> > Allow creating an iterator that loops through resources of one task/thread.
> > 
> > People could only create iterators to loop through all resources of
> > files, vma, and tasks in the system, even though they were interested
> > in only the resources of a specific task or process.  Passing the
> > additional parameters, people can now create an iterator to go
> > through all resources or only the resources of a task.
> > 
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
> >  include/linux/bpf.h            |  4 ++
> >  include/uapi/linux/bpf.h       | 23 ++++++++++
> >  kernel/bpf/task_iter.c         | 81 +++++++++++++++++++++++++---------
> >  tools/include/uapi/linux/bpf.h | 23 ++++++++++
> >  4 files changed, 109 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 11950029284f..c8d164404e20 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
> >  
> >  struct bpf_iter_aux_info {
> >  	struct bpf_map *map;
> > +	struct {
> > +		__u32	tid;
> 
> should be just u32 ?
> 
> > +		u8	type;
> > +	} task;
> >  };
> >  
> 
> SNIP
> 
> >  
> >  /* BPF syscall commands, see bpf(2) man-page for more details. */
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index 8c921799def4..7979aacb651e 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -12,6 +12,8 @@
> >  
> >  struct bpf_iter_seq_task_common {
> >  	struct pid_namespace *ns;
> > +	u32	tid;
> > +	u8	type;
> >  };
> >  
> >  struct bpf_iter_seq_task_info {
> > @@ -22,18 +24,31 @@ struct bpf_iter_seq_task_info {
> >  	u32 tid;
> >  };
> >  
> > -static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
> > +static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *common,
> >  					     u32 *tid,
> >  					     bool skip_if_dup_files)
> >  {
> >  	struct task_struct *task = NULL;
> >  	struct pid *pid;
> >  
> > +	if (common->type == BPF_TASK_ITER_TID) {
> > +		if (*tid)
> > +			return NULL;
> 
> I tested and this condition breaks it for fd iterations, not sure about
> the task and vma, because they share this function
> 
> if bpf_seq_read is called with small buffer there will be multiple calls
> to task_file_seq_get_next and second one will stop in here, even if there
> are more files to be displayed for the task in filter

I mean there will be multiple calls of following sequence:

  bpf_seq_read
    task_file_seq_start
      task_seq_get_next

and 2nd one will return NULL in task_seq_get_next,
because info->tid is already set
 
jirka

> 
> it'd be nice to have some test for this ;-) or perhaps compare with the
> not filtered output
> 
> SNIP
> 
> >  static const struct seq_operations task_seq_ops = {
> >  	.start	= task_seq_start,
> >  	.next	= task_seq_next,
> > @@ -137,8 +166,7 @@ struct bpf_iter_seq_task_file_info {
> >  static struct file *
> >  task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
> >  {
> > -	struct pid_namespace *ns = info->common.ns;
> > -	u32 curr_tid = info->tid;
> > +	u32 saved_tid = info->tid;
> >  	struct task_struct *curr_task;
> >  	unsigned int curr_fd = info->fd;
> >  
> > @@ -151,21 +179,18 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
> >  		curr_task = info->task;
> >  		curr_fd = info->fd;
> >  	} else {
> > -                curr_task = task_seq_get_next(ns, &curr_tid, true);
> > +		curr_task = task_seq_get_next(&info->common, &info->tid, true);
> >                  if (!curr_task) {
> >                          info->task = NULL;
> > -                        info->tid = curr_tid;
> >                          return NULL;
> >                  }
> 
> nit, looks like we're missing proper indent in here
> 
> 
> >  
> > -                /* set info->task and info->tid */
> > +		/* set info->task */
> >  		info->task = curr_task;
> > -		if (curr_tid == info->tid) {
> > +		if (saved_tid == info->tid)
> >  			curr_fd = info->fd;
> > -		} else {
> > -			info->tid = curr_tid;
> > +		else
> 
> SNIP
