Return-Path: <bpf+bounces-10142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 731FC7A1AB0
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A823F1C20BFF
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEADDDCA;
	Fri, 15 Sep 2023 09:37:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B56AD7
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:37:08 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41819BC
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 02:37:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so249456366b.3
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694770625; x=1695375425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k07mrQgvr71mnGbvfxEmEgVEHuj2PPd+FW0mOyTAgdc=;
        b=Zxd6vvMwtd/w2KAVOlIvP4evJAJW208wtxdyQyR0UNqSEua59ZuBi+C/uezpH0kqoQ
         nyzNSw+U00izJOfqYH2onH539+UgiEh++uwOuIcHOKvHYvnyc70XEyR1xtLvwxv7TZIa
         Z1xie8S0/JvxPYPlAo2Z+sgK34HADkVJ4sBp5X8kb95OmGC8o1GvF1LSrg4kYt4f9jax
         QQ3CFSoMxDDPi5te1AuAp9auqyWp6E6seOD8qtl4RMQjRdP0F7mNu+pBVog32RJk+9gl
         YVgYzTbJSk5zs753HR9uA6JBGR0gRXC8JPCBliI5iDMqDKqEGYtjGwacEEw0GbZilF3w
         pHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694770625; x=1695375425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k07mrQgvr71mnGbvfxEmEgVEHuj2PPd+FW0mOyTAgdc=;
        b=VOJsVWsKhqcOewPrGMJTaYTkTmo3p45FUiQEzpRWooCKMGrOGChIy7Ch1hl4CTlWHr
         ZTSs5ULB7nZmAgGU3rpeJix19ifHVUHvX3HbcyULuCkPGeVK4Kb35i7aWLnOk1p9c1zK
         7QuxW1dmmls+OYEc0igTCjNSSPXrqgcb2815yhWx1fN3liBDDNPZ+XZDPmeJ/SE4LsJs
         e6UiW3C5aGjdH9DeAP6J8hm0TtxcR1vkKkKs8Fj8rTOVT9w10AlUq9vqMut6/97wnnXT
         fKlHcmH4YfV5++amjY6iSIABPjeOktgijD/8JsNq2lJ+k4vGjOhknNIU+PGR0qxKDqIQ
         t7nw==
X-Gm-Message-State: AOJu0Ywyrx1arSWMDjHR8SObcXQ8+FysJNiAXuRR0y5xfc/Ft2GjbHzm
	ZH/nHLfKc2NH+idK8QtIYNw=
X-Google-Smtp-Source: AGHT+IHZAva+2KzVmZ8PzQNbKKPbC63wVPJjklwutTdJGyBdg4OCL8XhBZx9XS7JwI9YPG1RXcqWWQ==
X-Received: by 2002:a17:906:5a5a:b0:99c:55c0:ad15 with SMTP id my26-20020a1709065a5a00b0099c55c0ad15mr914526ejc.38.1694770625049;
        Fri, 15 Sep 2023 02:37:05 -0700 (PDT)
Received: from krava ([83.240.60.47])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709061b4800b0099c53c44083sm2156306ejg.79.2023.09.15.02.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:37:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Sep 2023 11:37:02 +0200
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org
Subject: Re: [bug report] bpf: Add pid filter support for uprobe_multi link
Message-ID: <ZQQlvlsl1U8K4ZZ7@krava>
References: <c5ffa7c0-6b06-40d5-aca2-63833b5cd9af@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ffa7c0-6b06-40d5-aca2-63833b5cd9af@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 10:12:34AM +0300, Dan Carpenter wrote:
> Hello Jiri Olsa,
> 
> The patch b733eeade420: "bpf: Add pid filter support for uprobe_multi
> link" from Aug 9, 2023 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	kernel/trace/bpf_trace.c:3227 bpf_uprobe_multi_link_attach()
> 	warn: missing error code here? 'get_pid_task()' failed. 'err' = '0'
> 
> kernel/trace/bpf_trace.c
>     3217                 err = -EBADF;
>     3218                 goto error_path_put;
>     3219         }
>     3220 
>     3221         pid = attr->link_create.uprobe_multi.pid;
>     3222         if (pid) {
>     3223                 rcu_read_lock();
>     3224                 task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
>     3225                 rcu_read_unlock();
>     3226                 if (!task)
> --> 3227                         goto error_path_put;
> 
> Should this have an error code?

yes, it should.. I'll send the fix below

thanks,
jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c1c1af63ced2..868008f56fec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3223,8 +3223,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		rcu_read_lock();
 		task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
 		rcu_read_unlock();
-		if (!task)
+		if (!task) {
+			err = -ESRCH;
 			goto error_path_put;
+		}
 	}
 
 	err = -ENOMEM;

