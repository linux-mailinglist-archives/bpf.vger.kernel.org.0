Return-Path: <bpf+bounces-10326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE617A543D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367981C209DD
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17A450D2;
	Mon, 18 Sep 2023 20:42:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E54450C5
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 20:42:41 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FAB8F;
	Mon, 18 Sep 2023 13:42:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso3830197b3a.0;
        Mon, 18 Sep 2023 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695069759; x=1695674559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngZ1EstcGqGLnVpdFDdugB3e4WOI4l3MNPHZWvgtMms=;
        b=TsY7U/pV9ty4y+pZpvzAg2wdm7FHhBhoD0I56zquy3Fpel2lGj66GvPjlpBXPQ5yW1
         PEecL2FyLiybhy2g8Caf5GLfXj8oZorNEuiUQpScPUZbApcQuuYaMwlpnzDjR7D+501e
         pDAIYV/2nJ1CX8w1yC8TbmJcwOEdjBP3N1rdJQX0GtY0JOkXbIP90vGb9BPScoZNtnJV
         7nc1P0RILbWInyjY+uJhXc0EQ3fv4uj21xNXK0R5zwMFW/CwupmYp7dZZwSct568ah1K
         Y6d4wkrShSiNkU7fhlPzaq+b8BWRkpQTB3ZzmaDoCWh0f+B/7ynNHjCCCt9Gc3VNVpWm
         9gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695069759; x=1695674559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngZ1EstcGqGLnVpdFDdugB3e4WOI4l3MNPHZWvgtMms=;
        b=ja2uj1UTALJStouRfz0JKaKQHDlVuhGyBf+ZVU5pgxdrEhlek8vnOrjyWswK547vw2
         jYPw4cgwE3/6VKSy0b78MJS53JICJHkVDCiZG2c0p9s07g68krQE7BP+1oNIMk9oyHc2
         mikOTWamqXZzxgcoeRLRT2mS+5b5LFLhn3e4GWKTNQNJ9bGZKTTkHpGiNVbSOKFodpfg
         8DZFLxg9oS6lkB+EWJ7Dj8DCN5nzWIF3any7/didL0xoa4AmUrC6waJgd5XpkuS20+A0
         9HMzaLpX2FE3dbMEdXhqdokW4HNbPWJevb8WZq6UGn2j2Xg84MD3lntVaKszNDUeCqiA
         g29w==
X-Gm-Message-State: AOJu0YwN1z0OLra26UWAtoP9iGGIRKZIchgnBSVpI4HoHGIRdfKiTeht
	FJSomGurBJEjkIyTV8CSghY=
X-Google-Smtp-Source: AGHT+IGEbkUWsT3HNQUKcXss26oaKpeKRSKtbTqmcR4z9CnOqpuBDR/O0UfQrMkfO1iMc31rsz4qEQ==
X-Received: by 2002:a05:6a20:12ce:b0:137:2f8c:fab0 with SMTP id v14-20020a056a2012ce00b001372f8cfab0mr11371176pzg.49.1695069759466;
        Mon, 18 Sep 2023 13:42:39 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id c10-20020a63a40a000000b0056b6d1ac949sm6950394pgf.13.2023.09.18.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:42:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 18 Sep 2023 10:42:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] cgroup: Prepare for using
 css_task_iter_*() in BPF
Message-ID: <ZQi2PQbtHX-bLzoR@slm.duckdns.org>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-2-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912070149.969939-2-zhouchuyi@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 12, 2023 at 03:01:44PM +0800, Chuyi Zhou wrote:
> This patch makes some preparations for using css_task_iter_*() in BPF
> Program.
> 
> 1. Flags CSS_TASK_ITER_* are #define-s and it's not easy for bpf prog to
> use them. Convert them to enum so bpf prog can take them from vmlinux.h.
> 
> 2. In the next patch we will add css_task_iter_*() in common kfuncs which
> is not safe. Since css_task_iter_*() does spin_unlock_irq() which might
> screw up irq flags depending on the context where bpf prog is running.
> So we should use irqsave/irqrestore here and the switching is harmless.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

