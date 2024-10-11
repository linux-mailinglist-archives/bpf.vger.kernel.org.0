Return-Path: <bpf+bounces-41781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E699AC85
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99651C23AA1
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29141CEAB0;
	Fri, 11 Oct 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aCFVtVYh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA71BD519
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674198; cv=none; b=TjmZOv9wbYy1NOx+1IBd1AwTlt4CuCqrXB3afa9r2RERAr/1izKBgUGkZM6H5qOzPxkMtN8zXFlXJnQSU/0YkpIIYx/H0u0PGz7JJLyCSh+XRQ0R17AMnMY6qnZhLKi5/3y8gWJe7TnCK+/WB9exKEWD8OKID9yshmICDnjS6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674198; c=relaxed/simple;
	bh=rP9cPu/oOztn/WQITtMS9fqM05qZ6hsvtaFoR4OoOWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPysJzO0+myL1CzQ52NCPzigLhyfrpLZMksZfhoKgPw0SEIH69hcHdTMdMIPlSY3jqUKeGk6jazar3rPQfz1VOiPA+pydZrHlUmWFoE6ji9B2OmseiVvTDQVZMNVWqDSZFT9jPAct/r2Lqj99oGUAQOiQpGzcgaT+/U4euVLXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aCFVtVYh; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8354599fd8aso88369539f.1
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728674195; x=1729278995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyqOvaZH0m4jFFnShhbbodjqaw8lvoeGo8+pexKDSA8=;
        b=aCFVtVYhvfRQDF6bYovarqtjk4EQXTgfNVaA0jMm9lrpIjgu2lno0xyOBkRs6DtPlo
         uIB4hKBOTapcHhvw2bAu1e3VhnPeldkQ2kVbWQotfSuRBHFNnwY3rfAyEArhlVUOThQ3
         hu3b/vmMIHXQwAH6EcGam+XMUJyyvOTRfivyxvvyDrH7H/C+3Ww9Kdk6A9fse5zRpLdX
         H06GXwYuoIzh3QxzEx2sdSmPGVKbu6q4z3sblhQViB5xrKw6poUTlerpYDH/+prJb9ay
         LbEs8Zf10zs+XF7CyCKjDrnTEY7QHh71zceFhLJOBcZYfccEOsxp+CC/SCUEL6L86gE0
         i1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674195; x=1729278995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyqOvaZH0m4jFFnShhbbodjqaw8lvoeGo8+pexKDSA8=;
        b=ofu68mNs1i0kRT5fAz/BpRZpuy7X1r1WrCage2iC53ek86IV4oxAQI0+YBId5dx6ey
         PMNMayqNg+Twg3PMxQsX6POtdqyT9SQp4BGkKpje4Foxev3+NnsifJa+rosecLF4rTao
         +wFV3KZChDV8wH7b/0ayZU3kGJTZ2Mf6rzvefxqG+VnJL01dIdd1/jVpH2tktaasQzsI
         UcA8SDkurCUwg70JWrv3gtdAubr6zZn+oOZwqB21dC1Ndq3i2U4Ccux+Bfak2QluvEHp
         2KF0vL88WBj3oUUkl3hw7wQnp9k0O7qzOpVW7puLLYnK14FV8Y90l2LoZSpv7Lcly66K
         qUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO+pkEwlgC+Kdd1/KrcNsHUZASuwTbGxurA+Sy6HTVSmVFf8p2dYcvVI8tonSSe1kvW5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhphIfDRBAJUxwgMW+LXAv2JMlDCDfik3r8dV7U2hyVHw4HhCp
	ig3AfAPZ8JpSBFrRqgtrU7MA0jRyL9retU2bPZdnjK2pgcYZfi1XQVsAdOZX7/M=
X-Google-Smtp-Source: AGHT+IGoHEMO/yD4yiGq9C78SGQjodBYNaaAnmYLZbcD9FMr222XQOM1sg3pV5sxxvJ2d3jPtQ6baQ==
X-Received: by 2002:a05:6e02:13a8:b0:3a0:a385:911d with SMTP id e9e14a558f8ab-3a3b5c71f26mr33007445ab.0.1728674195021;
        Fri, 11 Oct 2024 12:16:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdbcd2csm8323775ab.47.2024.10.11.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 12:16:34 -0700 (PDT)
Message-ID: <9f2b6f35-e923-4bf7-96cf-e4774e41ebb3@kernel.dk>
Date: Fri, 11 Oct 2024 13:16:33 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] Monthly trace report (Oct 2024)
To: Steven Rostedt <rostedt@goodmis.org>,
 syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, syzkaller-bugs@googlegroups.com,
 linux-block@vger.kernel.org, bpf@vger.kernel.org
References: <67094369.050a0220.4cbc0.000d.GAE@google.com>
 <20241011120028.1e4ed71c@gandalf.local.home>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241011120028.1e4ed71c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 10:00 AM, Steven Rostedt wrote:
> On Fri, 11 Oct 2024 08:25:29 -0700
> syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com> wrote:
> 
>> Hello trace maintainers/developers,
>>
>> This is a 31-day syzbot report for the trace subsystem.
>> All related reports/information can be found at:
>> https://syzkaller.appspot.com/upstream/s/trace
>>
>> During the period, 1 new issues were detected and 0 were fixed.
>> In total, 10 issues are still open and 38 have been fixed so far.
>>
>> Some of the still happening issues:
>>
>> Ref Crashes Repro Title
>> <1> 34      Yes   INFO: task hung in blk_trace_ioctl (4)
>>                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
> 
> If you check the maintainers file, blktrace.c has:
> 
> BLOCK LAYER
> M:      Jens Axboe <axboe@kernel.dk>
> L:      linux-block@vger.kernel.org

If syzbot can test this one, that would be appreciated. Guess here is
that we're stuck faulting under the debugfs_mutex. I took a look at the
syzbot reproducer, and no not going to attempt to run that... I strongly
suspect that the interesting bits there are:

1) Memory pressure/swap
2) blktrace setup/teardown, obviously

I do wish that once syzbot had a reproducer, it would continue
condensing it down into the most basic reproducer. Once you get into
"let's setup wifi, bluetooth, and tons of other things!" they become
almost impossible to run. And like in this case, I highly doubt they are
either related or useful.


diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8fd292d34d89..cefcad120495 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -617,8 +617,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return ret;
 }
 
-static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-			     struct block_device *bdev, char __user *arg)
+int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+		    struct block_device *bdev, char __user *arg)
 {
 	struct blk_user_trace_setup buts;
 	int ret;
@@ -627,28 +627,18 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (ret)
 		return -EFAULT;
 
+	mutex_lock(&q->debugfs_mutex);
 	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	mutex_unlock(&q->debugfs_mutex);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		__blk_trace_remove(q);
+		blk_trace_remove(q);
 		return -EFAULT;
 	}
-	return 0;
-}
 
-int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-		    struct block_device *bdev,
-		    char __user *arg)
-{
-	int ret;
-
-	mutex_lock(&q->debugfs_mutex);
-	ret = __blk_trace_setup(q, name, dev, bdev, arg);
-	mutex_unlock(&q->debugfs_mutex);
-
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
@@ -673,12 +663,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 		.pid = cbuts.pid,
 	};
 
+	mutex_lock(&q->debugfs_mutex);
 	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	mutex_unlock(&q->debugfs_mutex);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		__blk_trace_remove(q);
+		blk_trace_remove(q);
 		return -EFAULT;
 	}
 
@@ -732,12 +724,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	mutex_lock(&q->debugfs_mutex);
-
 	switch (cmd) {
 	case BLKTRACESETUP:
 		snprintf(b, sizeof(b), "%pg", bdev);
-		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
+		ret = blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
@@ -749,17 +739,16 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		start = 1;
 		fallthrough;
 	case BLKTRACESTOP:
-		ret = __blk_trace_startstop(q, start);
+		ret = blk_trace_startstop(q, start);
 		break;
 	case BLKTRACETEARDOWN:
-		ret = __blk_trace_remove(q);
+		ret = blk_trace_remove(q);
 		break;
 	default:
 		ret = -ENOTTY;
 		break;
 	}
 
-	mutex_unlock(&q->debugfs_mutex);
 	return ret;
 }
 

-- 
Jens Axboe

