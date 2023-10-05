Return-Path: <bpf+bounces-11435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52E7B9CBA
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B10B1B20996
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683F12B9B;
	Thu,  5 Oct 2023 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxSa8gwE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31311CA6
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 11:26:26 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD1524E8C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 04:26:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406402933edso7296705e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696505183; x=1697109983; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIoVj/vy/Hhfr+/0m/hFD6cIq0HW6TEhAF0rpYQmF/Q=;
        b=sxSa8gwEU2bJQV8BFuRm8xcA9prs1pTumWXh6IjDwCcIcms9rJjmGt7LfNez0S6XSn
         pkpI8Gx+xLfo7cx5cjcxo7b7t/BGcuQPLUJQAX0tzzXIkI9hkPp3u4PlwVOXiSXqbHZm
         EPSkxhT5mvtU499qw/Ci794aLOROpTQZ2v8O5EJRUp078hPb2C47Y1rVsuMb2xWSP6kp
         YeZM+zZ23xHpm+Ae0IhWsOdx3AANVYm+ormTc/+7QcehhjP7JletgwinC94yDAljdA7E
         J+IrJ513ji8+BpOxjuAUL2/NXwO1TBU7gVm/vpQJkmre+fF3HOlr/NylFGbS9a2lVNs2
         Gq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696505183; x=1697109983;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIoVj/vy/Hhfr+/0m/hFD6cIq0HW6TEhAF0rpYQmF/Q=;
        b=xD41yUQq7nU8XzMJw4wxC7xu/Qv2zWVfFSu9I9glCSYUvJUQGGRoBouNgxjMDivdtu
         c5QdEiplLf/OxjN6f5HqEaGpYE4W3g9m4Pk7vYkQfnShJUwnQI599/5fxyco2q5NNRwn
         8OrA7DAzHhYnI6oHfD+UdPw7ZmuJ0VT4MobGir9SRSEnCA8dO1aRT2wQrtVsQwp6ksm5
         7kdm5bSQjHLECqPsfsKlSHseh9cwA/2dKItkXMjWPZbY/QzUV75XcVJEX38vggFpBsS2
         8t9bvWK771Ya0OIK20PYTg9QstonMB3ddhTJE3uHDxYkdqURFimdG910BxHGT3K96dPN
         CmCQ==
X-Gm-Message-State: AOJu0Yw0kjSKQUb/Fise7NkjcyCuFw9D5foUej6DVkxt0giiT5PND68b
	F9M3mo6rFiUJCwIvRDfoA0fzvGF2TViCHqyXivA=
X-Google-Smtp-Source: AGHT+IHV/0U0tPheZ+n2tRuJTVjDaXfN/KItCLS2BjT7QFkuspBqhUW2+Fo63oVhCbRZkWcVtLYIiw==
X-Received: by 2002:a5d:5912:0:b0:31f:f11b:8b68 with SMTP id v18-20020a5d5912000000b0031ff11b8b68mr4011493wrd.71.1696505183048;
        Thu, 05 Oct 2023 04:26:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d628c000000b003233a31a467sm1578885wru.34.2023.10.05.04.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:26:22 -0700 (PDT)
Date: Thu, 5 Oct 2023 14:26:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org
Subject: [bug report] file: convert to SLAB_TYPESAFE_BY_RCU
Message-ID: <abcd771c-61f8-479b-ab15-af2f5b3ce896@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Christian Brauner,

The patch d089d9d056c0: "file: convert to SLAB_TYPESAFE_BY_RCU" from
Sep 29, 2023 (linux-next), leads to the following Smatch static
checker warning:

	kernel/bpf/task_iter.c:302 task_file_seq_get_next()
	warn: ignoring unreachable code.

kernel/bpf/task_iter.c
    258 static struct file *
    259 task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
    260 {
    261         u32 saved_tid = info->tid;
    262         struct task_struct *curr_task;
    263         unsigned int curr_fd = info->fd;
    264 
    265         /* If this function returns a non-NULL file object,
    266          * it held a reference to the task/file.
    267          * Otherwise, it does not hold any reference.
    268          */
    269 again:
    270         if (info->task) {
    271                 curr_task = info->task;
    272                 curr_fd = info->fd;
    273         } else {
    274                 curr_task = task_seq_get_next(&info->common, &info->tid, true);
    275                 if (!curr_task) {
    276                         info->task = NULL;
    277                         return NULL;
    278                 }
    279 
    280                 /* set info->task */
    281                 info->task = curr_task;
    282                 if (saved_tid == info->tid)
    283                         curr_fd = info->fd;
    284                 else
    285                         curr_fd = 0;
    286         }
    287 
    288         rcu_read_lock();
    289         for (;; curr_fd++) {
    290                 struct file *f;
    291                 f = task_lookup_next_fdget_rcu(curr_task, &curr_fd);
    292                 if (!f)
    293                         continue;

Should this be a break?

    294 
    295                 /* set info->fd */
    296                 info->fd = curr_fd;
    297                 rcu_read_unlock();
    298                 return f;
    299         }
    300 
    301         /* the current task is done, go to the next task */
--> 302         rcu_read_unlock();

Unreachable

    303         put_task_struct(curr_task);
    304 
    305         if (info->common.type == BPF_TASK_ITER_TID) {
    306                 info->task = NULL;
    307                 return NULL;
    308         }
    309 
    310         info->task = NULL;
    311         info->fd = 0;
    312         saved_tid = ++(info->tid);
    313         goto again;
    314 }

regards,
dan carpenter

