Return-Path: <bpf+bounces-15223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD897EEC83
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091991C20864
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321AADDD2;
	Fri, 17 Nov 2023 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdQHG9Oe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09463194;
	Thu, 16 Nov 2023 23:17:25 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1ef36a04931so884972fac.2;
        Thu, 16 Nov 2023 23:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700205444; x=1700810244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QukYki9H1r7IbI+PSJf1zlNk9CvZgDpPCQZkyC5hsQ=;
        b=JdQHG9OezkYxd6ET/4FpHe7GDkwNWH1b+XrYyDHu6H4kmxLPpaNeMfIJDxJvMXKgg7
         nO/nPo46jjVaAhZkdj2AxNMNnmohRoPlrnOZHnRCeKs2b6XL8QhJ/XM1R4r+//HTF5Hm
         UezWuI5ebUQOX5u0CegZXbK/v308L9Ux4mS5mkYjKjO8aypmBKVuZzJmyFIS9IzKnhcK
         k30+8PTMsoxq9JSyRM6JG9uBYWe235LQ98ai4j5aJwOjMRCj+Q+95xonf2k8qNFS2BJD
         AYWXErVGmk6xhvZjSfdZzfJqxfDon1xg7UE42MIIcwnaQxGA677RiTFDOmk6gnNJxZ4J
         3hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700205444; x=1700810244;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QukYki9H1r7IbI+PSJf1zlNk9CvZgDpPCQZkyC5hsQ=;
        b=Fy5IArTkU1prE7Zqog1brKH0AYzPOhcU3lZv/Pboq/C1UC7ic525ohniOEK64p9gkR
         TJrH7L43iBr4qdiJwFIyMdSr1aGdgm0h8X3ZbIEumvas9BG5ktZHbDuTMfd5dPmvou2+
         6IYng4vACYRQcqyQZsQ1POWMwkusLrZS+bX6u3V7eEFSeSDrHRgcPJ07NWRy5MrwfyCp
         Q0NlciIt5EDZ0q3BWbHDn1qCO+4HdzA66MywovTZyNBVTIyPBoimwEuNnjP1CeD4Jqz4
         PJFfS6d4Kqi39d/udK02iScp5hU76BoowV6qZ5qlY4mJzj13YAND13TRd0By5E4W0db/
         ZoBg==
X-Gm-Message-State: AOJu0Ywh7hQu1gb4Eb7FgdukGbjP5KNOBZmayWzLJM+N7aM23WbMbmyJ
	FRw2Y9Y2+w8linBD0dpgXX0=
X-Google-Smtp-Source: AGHT+IHLYo0uoC1KYA0iWIDNmfOWMks4dcPy/rtVEARD9CPrVr2MsvlvbTJgKhiNy/wvlyPz8Yv6qw==
X-Received: by 2002:a05:6870:32d4:b0:1e1:371:c3da with SMTP id r20-20020a05687032d400b001e10371c3damr22863308oac.20.1700205444205;
        Thu, 16 Nov 2023 23:17:24 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id c10-20020a631c4a000000b005b82611378bsm811351pgm.52.2023.11.16.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 23:17:23 -0800 (PST)
Date: Thu, 16 Nov 2023 23:17:22 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 daniel@iogearbox.net, 
 bpf@vger.kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 mattyk@nvidia.com
Message-ID: <655713825798c_55d732088@john.notmuch>
In-Reply-To: <20231116145948.203001-15-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-15-jhs@mojatatu.com>
Subject: RE: [PATCH net-next v8 14/15] p4tc: add P4 classifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> Introduce P4 tc classifier. A tc filter instantiated on this classifier
> is used to bind a P4 pipeline to one or more netdev ports. To use P4
> classifier you must specify a pipeline name that will be associated to
> this filter, a s/w parser and datapath ebpf program. The pipeline must have
> already been created via a template.
> For example, if we were to add a filter to ingress of network interface
> device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
> following command:
> 
> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>     action bpf obj $PARSER.o section prog/tc-parser \
>     action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs generated
> by the P4 compiler and will be the representation of the P4 program.
> Note that filter understands that $PARSER.o is a parser to be loaded
> at the tc level. The datapath program is merely an eBPF action.
> 
> Note we do support a distinct way of loading the parser as opposed to
> making it be an action, the above example would be:
> 
> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>     prog type tc obj $PARSER.o ... \
>     action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> We support two types of loadings of these initial programs in the pipeline
> and differentiate between what gets loaded at tc vs xdp by using syntax of
> 
> either "prog type tc obj" or "prog type xdp obj"
> 
> For XDP:
> 
> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
>     prog type xdp obj $PARSER.o section parser/xdp \
>     pinned_link /sys/fs/bpf/mylink \
>     action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> The theory of operations is as follows:

You've lost me here. You have a BPF parser program and some BPF actions.
Why not have the parser program just call the BPF action?

It seems the action is based on LPM or some software like TCAM. So
steps in BPF would be,

   Parse -> bpf_map_lookup to find action -> call action

Just use the normal way to load the bpf program through 'tc' or 'xdp'.
Or its all about hardware, but I still have no idea how this BPF parser
gets into hardware and how these actions get there. So we can't even
evaluate what that looks like.

> 
> ================================1. PARSING================================
> 
> The packet first encounters the parser.
> The parser is implemented in ebpf residing either at the TC or XDP
> level. The parsed header values are stored in a shared eBPF map.
> When the parser runs at XDP level, we load it into XDP using tc filter
> command and pin it to a file.
> 
> =============================2. ACTIONS=============================
> 
> In the above example, the P4 program (minus the parser) is encoded in an
> action($PROGNAME.o). It should be noted that classical tc actions
> continue to work:
> IOW, someone could decide to add a mirred action to mirror all packets
> after or before the ebpf action.
> 
> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>     prog type tc obj $PARSER.o section parser/tc-ingress \
>     action bpf obj $PROGNAME.o section prog/tc-ingress \
>     action mirred egress mirror index 1 dev $P1 \
>     action bpf obj $ANOTHERPROG.o section mysect/section-1
> 
> It should also be noted that it is feasible to split some of the ingress
> datapath into XDP first and more into TC later (as was shown above for
> example where the parser runs at XDP level). YMMV.
> 
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

