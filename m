Return-Path: <bpf+bounces-10137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C507A1709
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 09:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A70C1C213EA
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 07:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDCD26F;
	Fri, 15 Sep 2023 07:12:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85196D26A
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 07:12:41 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A1115
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 00:12:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31fd067e8d0so1782607f8f.1
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761959; x=1695366759; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qsn7pyyoG/Mb45PVYsIocmO75NSQ6sbZ76J5ktQo7xk=;
        b=jheXCcWcFT1OitZIgfIBkQHBAd3VTXATlTG7sRP49JQ3+d6KxjRUeoCeKHj+46dEUZ
         2qsvXRpR4RB+W5npIqFdbWa6E+jzmn0DfKVPg7hhUCxpWF0J46j06yV9g63SPHNLvtii
         7bmBMTKREk9WQyzBdrLgBkBsW4Je6qdM9sjqBUkoGKZ5rmTij6pWIRaZM9YgF6Uy1Dzh
         EguN9CuLqtMI+RYeOXs45aMgm/zAk9Y3I+h1D8ZpgEXSGiE0kO3PuvkOC0wmFkrzLWfC
         UF7WYKNfcnva5yZCQG4p9nTsYM4ZMRXKKUCpD8rJizukJEfqeaZx/cdL5lgLJb6++D1m
         Xc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761959; x=1695366759;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsn7pyyoG/Mb45PVYsIocmO75NSQ6sbZ76J5ktQo7xk=;
        b=NIIbm8/UUu/1igAjrSPiMpendKCFNe+eD1+F9zkLq6usTy4LXr56PnYi2d9enhpQYN
         /mFgQl5T7JounTzyaqFvgak9dWgy4sBE4508UNTdXY9vpx77aLmHW7gUh4gyRJNx+0IB
         ZK/nTiitI/nOQoEVB2vdfX0MqNSDL4Krf8Gqwq/IqpqvgJ3mnC/e9OKrjfFl3QXnEav6
         YVwI+9v8pJ7q2+G2Qe3AwaydIQqAlp2pSLR+s/cuuLMwuUBp948KOl+dauONUSLSq7Ih
         BlRBBDUDx5qtym/8C6p9pn63oL6zfbsgCqX9bvvfNnlrt09GCqdgEtd8euylz26s7STj
         krpw==
X-Gm-Message-State: AOJu0Yygi3GJyDAtoK1A/LywDgUW/VrPxsevdJNQN5fPSz0RT8FVgq82
	9ZatVjWX6B1iVA3iAOt01vpQuQi7rkXU0BWuD7E=
X-Google-Smtp-Source: AGHT+IEs9B6PxlZpMxH5T8lOJqHZlYZjKd8pG0M9NCfCyMXNX9ngf2T9uRoSwqeGzxz6vOj1pwy0Gg==
X-Received: by 2002:a5d:4a8b:0:b0:317:5f04:bc00 with SMTP id o11-20020a5d4a8b000000b003175f04bc00mr552535wrq.27.1694761958815;
        Fri, 15 Sep 2023 00:12:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q2-20020adff782000000b00317f70240afsm3646297wrp.27.2023.09.15.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:12:38 -0700 (PDT)
Date: Fri, 15 Sep 2023 10:12:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jolsa@kernel.org
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Add pid filter support for uprobe_multi link
Message-ID: <c5ffa7c0-6b06-40d5-aca2-63833b5cd9af@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Jiri Olsa,

The patch b733eeade420: "bpf: Add pid filter support for uprobe_multi
link" from Aug 9, 2023 (linux-next), leads to the following Smatch
static checker warning:

	kernel/trace/bpf_trace.c:3227 bpf_uprobe_multi_link_attach()
	warn: missing error code here? 'get_pid_task()' failed. 'err' = '0'

kernel/trace/bpf_trace.c
    3217                 err = -EBADF;
    3218                 goto error_path_put;
    3219         }
    3220 
    3221         pid = attr->link_create.uprobe_multi.pid;
    3222         if (pid) {
    3223                 rcu_read_lock();
    3224                 task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
    3225                 rcu_read_unlock();
    3226                 if (!task)
--> 3227                         goto error_path_put;

Should this have an error code?

    3228         }
    3229 
    3230         err = -ENOMEM;
    3231 

[ snip ]

    3288         err = bpf_link_prime(&link->link, &link_primer);
    3289         if (err)
    3290                 goto error_free;
    3291 
    3292         kvfree(ref_ctr_offsets);
    3293         return bpf_link_settle(&link_primer);
    3294 
    3295 error_free:
    3296         kvfree(ref_ctr_offsets);
    3297         kvfree(uprobes);
    3298         kfree(link);
    3299         if (task)
    3300                 put_task_struct(task);
    3301 error_path_put:
    3302         path_put(&path);
    3303         return err;
    3304 }

regards,
dan carpenter

