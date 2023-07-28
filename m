Return-Path: <bpf+bounces-6213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3026D7670EC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99D9282798
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E514288;
	Fri, 28 Jul 2023 15:47:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D3134B0
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 15:47:15 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162AE0
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 08:47:14 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3FCB1C151B1E
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690559234; bh=myUuw992nxQ2a+Q8rrAvIB1/fqjg3Julhj53tV70HjA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=C14dRYePHP6gqx6har6T3e8voKD/GviebMkMgGQng0v64p3InshBKjbVGT04N7okQ
	 sYSyJO28hqAV/wSHZrZpnjJR98SFqMfZH34WhvZf+lcFk3FME57iyRl6cSf/u3iXwX
	 5dustpc7unCp/hUDtEKqrFgZLIzR/UgCWGu4zD9U=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 08:47:14 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EA118C151065;
	Fri, 28 Jul 2023 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690559233; bh=myUuw992nxQ2a+Q8rrAvIB1/fqjg3Julhj53tV70HjA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=RTprEWqNf6Cov5ewDXyGb4/Wjm4yZq2NPnxMIlxjuNpM5LC8HpnJhgw4DKaTlPExF
	 s5CldZhAKJDOrmKoMeTY+yEh6mN/SQTqt4TcemgvK/6wqfVk58bCta4e2t0QpXkt+P
	 UeMiDM4qIo3uDYGxvYz3FMzkeUxXy2d5h9QbuXl0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A7BADC151065;
 Fri, 28 Jul 2023 08:47:12 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.404
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8DLSo0Oo9GVx; Fri, 28 Jul 2023 08:47:08 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4ABFAC14CE54;
 Fri, 28 Jul 2023 08:47:08 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-40648d758f1so15264391cf.0; 
 Fri, 28 Jul 2023 08:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690559227; x=1691164027;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x87kaDQTgH8avW80JIRl1fZNPVsY9slrDLN0QG8WCo4=;
 b=hDlsDTLdeyImYu9NCKB3u7I3+HgAxdLCiM7RJtUYbJtyplt4FxaMBoqC2/4JtGIx4N
 Tv/SLV/QyGLlta+idgdLhcCYw82wL/s6TrDuzd/g/9UK/HtbQkvUSAodA//w5GOuUSPo
 1/iBjCyYE8IYm7/FU58sX9jiQxS4d9B+mSwVUTgMiZvaljtc7BLtGK4xbZgXuXnD3skR
 f6yzcuCN5i4Lqda7DyJIPZUg1IHzpzR1OyJsMgXDUIaKlF+62WoSfMOnarolfvEqoQDv
 lWPtj6k/DvJsRh9MQ6MoWf/JsUnZTogJU/kXv9iesZjn269203Tx56AZ3MnlYwu7dsOl
 SfNA==
X-Gm-Message-State: ABy/qLa4AfP16xKABDcyRH2QOalORSRNeEC4ut18ycGHswn0i2VYxRo0
 OyheaAwGGHqucEEiLXCWW8WjSR0UtuTldQ==
X-Google-Smtp-Source: APBJJlFquI3pqUuItwDh5JDtpMAJNG08dx0PZ2GBjmTeMWzyh011jI3ifGcaxIN2H0EHPKGUNZZ7MQ==
X-Received: by 2002:a05:622a:9:b0:400:9c4e:2abe with SMTP id
 x9-20020a05622a000900b004009c4e2abemr3459309qtw.13.1690559226762; 
 Fri, 28 Jul 2023 08:47:06 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5bb1])
 by smtp.gmail.com with ESMTPSA id
 c27-20020ac8009b000000b004054b435f8csm1235011qtg.65.2023.07.28.08.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 08:47:06 -0700 (PDT)
Date: Fri, 28 Jul 2023 10:47:04 -0500
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, bpf-chairs@ietf.org
Message-ID: <20230728154704.GB7328@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Afli9AGejowGZ2BNqOgvNjxGJpQ>
Subject: [Bpf] BPF @ IETF 117 Follow Up
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello everyone,

We had our first official meeting of the BPF working group at IETF 117
on Monday in San Francisco. The meeting was very productive, so thank
you to all those who attended and participated. We're excited to
continue making progress on standardizing BPF with the IETF, and
hopefully we can carry forward the momentum of the conference as we
iterate on the many topics that were discussed.

The meeting can be viewed in its entirety on YouTube at [0], and the
meeting minutes can be accessed at [1]. A special thank you to those who
collected notes, and to the presenters.

[0]: https://www.youtube.com/watch?v=jTtPbJqfYwI
[1]: https://notes.ietf.org/notes-ietf-117-bpf

Meeting Recap
-------------

Let's go over some of the highlights from the meeting:

1. Issue Tracker

The WG expressed interest in using an issue tracker to ensure that any
points that have been raised for discussion are properly tracked. A few
different options were proposed, with the final rough consensus being
that the chairs would pick an issue tracker and workflow for the WG.
We'll get to work on this once the conference has concluded, and will
notify you when we have everything setup.

2. eBPF Instruction Set Verification I-D called for adoption

A call for adoption took place for Dave Thaler's eBPF Instruction Set
Verification I-D [2].

[2]: https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/

Rough consensus was obtained at the meeting, and we'll follow up with a
formal call for adoption on the email list in the near future.

There are already some reviews and discussions following the meeting,
which is great to see. Please keep the reviews coming!

3. ISA Extension Policy

Dave Thaler led a discussion on what the policy should be for extending
the BPF Instruction Set Architecture (ISA) for future instructions which
are added after the initial ISA standard document is ratified. The
slides for this discussion can be found in [3].

[3]: https://datatracker.ietf.org/meeting/117/materials/slides-117-bpf-isa-extension-policy-03.pdf

We covered a lot of ground in this discussion, but we need to close the
loop on a few things such as whether the registry should be in the IANA
or the Linux kernel tree, what type of ISA registration policy to use,
etc.

4. All things ABI

We discussed ABI and BPF program interoperability in a number of
different contexts. Will Hawkins presented the slides in [4], and
indicated that he had begun work on an ABI document that he would send
to the bpf@ietf.org and bpf@vger.kernel.org lists sometime in the near
future.

[4]: https://datatracker.ietf.org/meeting/117/materials/slides-117-bpf-abi-00.pdf

Dave Thaler also presented on a topic related to ABI: the eBPF ELF
Profile Specification. The slides can be found in [5]. In Dave's
presentation, he pointed out that the btf.rst document [6] currently has
an "ELF File Format Interface" section that should likely be moved into
a separate document such as elf.rst. This is also the case for
instruction-set.rst, as mentioned in the thread in [7].

[5]: https://datatracker.ietf.org/meeting/117/materials/slides-117-bpf-elf-profile-specification-00.pdf
[6]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Documentation/bpf/btf.rst
[7]: https://mailarchive.ietf.org/arch/msg/bpf/-NrwjA_6EHQ8y83cMZZGzbT8-wc/

We agreed that the next step would be to move these ABI sections out of
any document that we're expecting to be a Proposed Standard, and into
one or more separate .rst files. While our immediate focus is on the ISA
document, getting a head-start on the ABI document(s) seems prudent if
folks have the bandwidth.

Closing Thoughts
----------------

Overall, the meeting seemed to go very well. We're still in the process
of learning how to effectively collaborate between the IETF and Linux
kernel communities, but it's encouraging to see the progress being made
on the ABI doc(s), and especially the ISA doc. Thank you everyone for
being patient as we navigate everything, and for setting a respectful
and collaborative tone for our WG. That said, if anyone is finding the
arrangement difficult or has feedback of any kind, please feel free to
reach out to us at bpf-chairs@ietf.org so we can help.

Lastly, we're excited to mention that the first ACM SIGCOMM workshop on
eBPF and Kernel Extensions will be taking place on September 10, 2023 at
Columbia University in New York, NY. The list of accepted papers [8]
looks very interesting, so consider attending if you'd like to learn
more about BPF, and see what kind of BPF-related research is taking
place.

[8]: https://conferences.sigcomm.org/sigcomm/2023/workshop-ebpf.html

Regards,
David and Suresh

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

