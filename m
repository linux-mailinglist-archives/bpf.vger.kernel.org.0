Return-Path: <bpf+bounces-9323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35179384A
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0371C2092F
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974FE1C3B;
	Wed,  6 Sep 2023 09:32:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB811398
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 09:32:03 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9E170B;
	Wed,  6 Sep 2023 02:32:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bd0d19a304so56675781fa.1;
        Wed, 06 Sep 2023 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693992720; x=1694597520; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0j1GUZDUHTZyz6OodkfAkKlIJdEvZl5TSnWqqW/Tf8=;
        b=EeEHlel7UmWlFT7uWGr2SnAkke0wfwcXI5+HVjZ+I6Vo1Ky81YGmTnaIm0QCWTqMe2
         9FNvfBjr8HHvIlvuisVLzUxn5goJWlnrUFn4ul0aC9XIuJ0SkgINAvWPfiqq2a6xQgt8
         idI9zrZf6FJqnwRG1NoemlxbU023BTJ1O4IV8QtNTPO1CgBugmsd5YugKN5NGxvxdpJE
         3w+gUiFKCoxRH6ciNTiE4aJav6DXGrSgCyDsQ6aBdH5xwQkN+ErPFH1PJJ0Box6eihb5
         BLOPdkKPpI+Fz/kyBNFEuf4TUFcmUUnl413YqxbdEszyRciNPUfkr5rPtRunzp/tA1R0
         3L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992720; x=1694597520;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0j1GUZDUHTZyz6OodkfAkKlIJdEvZl5TSnWqqW/Tf8=;
        b=hbjqrq/KWnocWfMOTMy4JZWgRwNT5FqiViEDymUL8aGO5XunBdzHCzmUCtFmv+EPhr
         WIlxx/6CGPGrACVwGD7RoRBWf9XdFop0qCXzYaNLIOBqdCzti7JVKe0SG4XxqtPRZAcp
         Cqpr5lRl45mi6HhsuB4ndkFIg16idVlk20zh11zDAIoiqquQ3id2bTaD/vcLqb4rN0Vz
         y8p+/8K/vLv6DaRLX1fxS1z3W5b9tIxyospnBDPvU2jDXBykglPBYU6oA72CZXI5hhpw
         NgsixvU8UhmjAHD8u5DwhtzbGI0Vsg3BvoftUSD0uJ7O0TXipVgP70fGbW61r0yMGYql
         42UA==
X-Gm-Message-State: AOJu0Yz0p+y2AEhww8RdPR5USj+11sG5QwNYR4JDjhyeuoHM+JmVHDaz
	7gi/WyRAKFPHZJgw0e1JXV/hP+0fq7eX1oUfr5I=
X-Google-Smtp-Source: AGHT+IFCiHXuSO55+qSuAuYI+tAIFaIk0hNLqcjWr9xssUtrfnTHCAZdwIwDFu9Yj9POG7nv8bEC1A==
X-Received: by 2002:a2e:9203:0:b0:2b4:6e21:637e with SMTP id k3-20020a2e9203000000b002b46e21637emr1831678ljg.16.1693992719625;
        Wed, 06 Sep 2023 02:31:59 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c028600b003feea62440bsm19221702wmk.43.2023.09.06.02.31.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:31:59 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@google.com>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Shubham Bansal <illusionist.neo@gmail.com>,  Mykola
 Lysenko <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/8] arm32, bpf: add support for unconditional
 bswap instruction
References: <20230905210621.1711859-1-puranjay12@gmail.com>
	<20230905210621.1711859-5-puranjay12@gmail.com>
	<ZPeecV807AVEkCJB@shell.armlinux.org.uk>
Date: Wed, 06 Sep 2023 09:31:58 +0000
In-Reply-To: <ZPeecV807AVEkCJB@shell.armlinux.org.uk> (Russell King's message
	of "Tue, 5 Sep 2023 22:32:33 +0100")
Message-ID: <mb61pjzt33awh.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05 2023, Russell King (Oracle) wrote:

> On Tue, Sep 05, 2023 at 09:06:17PM +0000, Puranjay Mohan wrote:
>> The cpuv4 added a new unconditional bswap instruction with following
>> behaviour:
>> 
>> BPF_ALU64 | BPF_TO_LE | BPF_END with imm = 16/32/64 means:
>> dst = bswap16(dst)
>> dst = bswap32(dst)
>> dst = bswap64(dst)
>> 
>> As we already support converting to big-endian from little-endian we can
>> use the same for unconditional bswap.
>> Since ARM32 is always little-endian, just treat the unconditional scenario
>
> This is not true. Arm32 BPF is disabled for BE32 but not for BE8. It's
> entirely possible to build a kernel using BE8 for ARMv7 and have the
> BPF JIT enabled:
>
>         select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
>
> So it's not true to say "Since ARM32 is always little-endian".

Sure, I will change the commit message in next version.

Thanks,
Puranjay

