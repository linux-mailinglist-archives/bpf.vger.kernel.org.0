Return-Path: <bpf+bounces-12138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22957C85F7
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235CFB20AAE
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 12:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210FE11CBF;
	Fri, 13 Oct 2023 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UqLa6NO6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15ACE540
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 12:41:50 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E5DBF
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 05:41:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so340064966b.3
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697200907; x=1697805707; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zAtUUSQKTbSgVXRh99ECQlEUoQwRZ0ddPAxa6nbo9jw=;
        b=UqLa6NO6eCSy4f6l6qnFZZvG1NLIreUKE/cx3s80FiXla9bQom8O4KqJPTViSPY/7t
         zZRYgnCge6zNQT9ltJPQmbVPFXaZBnOiH4iRIpu4JJXU8K0nDfVEwinGjslF8N/UeK0B
         ZTGyOhni2R2cLSf/xakf3G9BEa7TI686wAVc1TaIXETbgWwXwuR11cDHkqvrBDsFkSSX
         CYvIepIwB0zoc4oCKZQePWZD7VtkzG83EIFwcu8NQS9/4SjbSHDWXo4pFMDC5c0F62LX
         doE3yvIxd2Dng1SZtaz2yNk6MekZZUeW8gjhfcjO/4W2lPDeoZsRe0kwe9y4B8ti0jXI
         NO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697200907; x=1697805707;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAtUUSQKTbSgVXRh99ECQlEUoQwRZ0ddPAxa6nbo9jw=;
        b=EDpzF4PVGPO1WrG+GhzX0vg/MamBuQLTQ9rd7xu9y0RYHZG7mOD9u3HfP9heSLynzS
         Ljm3Ir0eOqhf6C5lurdFvz5KRLLZQYOfZjdgiO6Fm+fSjuyVWgMs6XgXo/9m44EbQrQ4
         BJ57LTJHkmxl4HiapvNq0G134Pyh1URfY3A8RLRkjx+N2hULSkfONpNgOReD6wdhBgSp
         gFSIgR+fw6+eEwx9oCjy+SXKCzU7CbNMJKRYhJxCLphRD5v01zYSIDho9SGesGmtmJoD
         9JUioYcnSHTSqs5eeUJxNBE/5E52R/5T9TOeEpbY5N6wboWLI8gj49a99Yyq9Ti3a7Se
         5exA==
X-Gm-Message-State: AOJu0Yw9wW9peQBJjXZMu/fBDQHcGIilMPkxDArNtAAEytovUoPFboqu
	7AI10fhgOFdVxir7wtRPymfZqw==
X-Google-Smtp-Source: AGHT+IHVkDh/M8xtvKyLUUTsbSftqLXzuumz1RW5JMGvNcPS4u2NZ4mLpn6yOZDCnJwZuNludFR0Gg==
X-Received: by 2002:a17:907:2724:b0:9b2:8c37:82a with SMTP id d4-20020a170907272400b009b28c37082amr22595995ejl.35.1697200907221;
        Fri, 13 Oct 2023 05:41:47 -0700 (PDT)
Received: from cloudflare.com (79.184.153.26.ipv4.supernova.orange.pl. [79.184.153.26])
        by smtp.gmail.com with ESMTPSA id lf18-20020a170906ae5200b009ae5e46210asm12368110ejb.99.2023.10.13.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:41:46 -0700 (PDT)
References: <20230927093013.1951659-1-liujian56@huawei.com>
 <20230927093013.1951659-2-liujian56@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/7] bpf, sockmap: add BPF_F_PERMANENT flag
 for skmsg redirect
Date: Fri, 13 Oct 2023 14:34:49 +0200
In-reply-to: <20230927093013.1951659-2-liujian56@huawei.com>
Message-ID: <87v8baelti.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 05:30 PM +08, Liu Jian wrote:
> If the sockmap msg redirection function is used only to forward packets
> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
> program is the same each time. In this case, the BPF program only needs to
> be run once. Add BPF_F_PERMANENT flag to bpf_msg_redirect_map() and
> bpf_msg_redirect_hash() to implement this ability.
>
> Then we can enable this function in the bpf program as follows:
> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENT);
>
> Test results using netperf  TCP_STREAM mode:
> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
> done
>
> before:
> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
> after:
> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85
>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---

I adapted a scripted benchmark for sk_msg redirect I had written
recently [1] to double check these numbers.

Looks good. The boost is reproducible. Sample test run captured at [2].

  *** netns-to-netns TCP latency test ***
  
  sockperf: Summary: Message Rate is 87638 [msg/sec]
  sockperf: Summary: BandWidth is 123.027 MBps (984.216 Mbps)
  
  *** netns-to-netns TCP latency test WITH sockmap bypass ***
  
  sockperf: Summary: Message Rate is 135718 [msg/sec]
  sockperf: Summary: BandWidth is 190.522 MBps (1524.177 Mbps)
  
  *** netns-to-netns TCP latency test WITH sockmap bypass + F_PERMANENT ***
  
  sockperf: Summary: Message Rate is 148700 [msg/sec]
  sockperf: Summary: BandWidth is 208.746 MBps (1669.971 Mbps)

And, as expected, I'm seeing just a different prog run count when using
F_PERMANENT after the test:

  175: sk_msg  name sk_msg_prog  tag 7c26e0d6e8e92a36  gpl run_time_ns 245761059 run_cnt 4071588
          loaded_at 2023-10-13T14:27:28+0200  uid 0
          xlated 80B  jited 62B  memlock 4096B  map_ids 88,90
          btf_id 173
  177: sk_msg  name sk_msg_prog_once  tag e460e6fffdc8ff8a  gpl run_time_ns 1441 run_cnt 1
          loaded_at 2023-10-13T14:27:28+0200  uid 0
          xlated 80B  jited 62B  memlock 4096B  map_ids 88,90
          btf_id 173

Feel free to add my:

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

[1]
https://github.com/jsitnicki/srecon-2023-sockmap/blob/test-f_permanent/examples/redir-bypass/test_redir_bypass.sh
[2] https://github.com/jsitnicki/srecon-2023-sockmap/blob/test-f_permanent/examples/redir-bypass/example_redir_bypass.txt

