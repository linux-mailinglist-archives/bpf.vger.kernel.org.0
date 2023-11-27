Return-Path: <bpf+bounces-16003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC60A7FAB32
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 21:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9713B281BDA
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82945C1B;
	Mon, 27 Nov 2023 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VA2VBuHl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Rk9o4sag"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E71B6
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 12:18:23 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2BC67C15198D
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1701116303; bh=KsXUGSc8BLQoctpkzIadjQgnqy4NWt5ieifzcOrQOgs=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=VA2VBuHl/aPuoHaC/VTy3XFT/KEkCnpfKHWrK6q36JgcuAh2gsiJ8H6vaS20U5eMW
	 UVTlFy7MKmV4OWhtmpL78NHv9ZTZxM5DqV/KVNM0UU6tsMZ+Jkj17B+/YCywgtXo2l
	 iuMyoETfpVAuuwLnGuVo37stYWPkSfaQSWMDsknM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Nov 27 12:18:22 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B5D63C15152F;
	Mon, 27 Nov 2023 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1701116302; bh=KsXUGSc8BLQoctpkzIadjQgnqy4NWt5ieifzcOrQOgs=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=Rk9o4sagg8SvCmgAV8lM2cxnni9bpRAjY9M9vYVV6BlDNsz2GaHTVBLZEguDptaQT
	 /Dl8Lv5pAb5oC4jNJg/mAWN7H/Qfzza17N3vxnqWpLQl2JK8pU4dKvU323h2RDYTfM
	 YSESCtk2CP6vbGZqsAOWEZIdweKnHWGfmShuZ8pA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8EBE0C15152F
 for <bpf@ietfa.amsl.com>; Mon, 27 Nov 2023 12:18:21 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.407
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eJkm3uGpyZDy for <bpf@ietfa.amsl.com>;
 Mon, 27 Nov 2023 12:18:20 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EF813C151520
 for <bpf@ietf.org>; Mon, 27 Nov 2023 12:18:20 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-6d7e8da5e99so2611879a34.2
 for <bpf@ietf.org>; Mon, 27 Nov 2023 12:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701116300; x=1701721100;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DS3whckSH7/U1pY2zav0ht92ISA+ZglbMKMja86Eno=;
 b=J3HvW48f0qvENgSnikEI/vlSAWl60gcvWf5uy0NWjbiH15ZhNIK8G0CcNbgrwO0isU
 Rm3eT91uo3jc0fUuGOmI4zEYTducZe2mRA9zRTZsluM2k8oy62uHt6PZdl3hPELihVAM
 xClRRiuJJ17lMPhY4IztlrQQ0KNVbc6Fczfl06KfN43cNyjUZeJGCnBbLBqdJRsbxX7I
 tlVj8JHeE4QSMH5F5AgLYx/ADFzVsqXOY4sJ0YNYPabqZWcIZHuuJbDfk8uiVJRigz3X
 XPY60gYwLFiitAvTidTesbLa7KqdMMgVaOrrTepEy+EohhXzVaau/ry3fggQGp78mk4K
 O/Ng==
X-Gm-Message-State: AOJu0YxzauNV1w2/fwlPIluImKRDn01Qi5lkafgwdOAgmvFqCBw/NqZT
 v49uLNWcD1SR5wD73a/2Ci6cXdJOhZ7T8yEs
X-Google-Smtp-Source: AGHT+IGl1kYxdqsywHq4xwEal56V3iwb7YhAcNDIezY974BACP4tUQY1FcJl1U/udKCvhphlRSddpA==
X-Received: by 2002:a9d:5e13:0:b0:6b7:56d9:533 with SMTP id
 d19-20020a9d5e13000000b006b756d90533mr12781926oti.28.1701116299692; 
 Mon, 27 Nov 2023 12:18:19 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 e29-20020a0cb45d000000b0066cf4fa7b47sm2418380qvf.4.2023.11.27.12.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 12:18:19 -0800 (PST)
Date: Mon, 27 Nov 2023 14:18:17 -0600
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, suresh.krishnan@gmail.com, ek.ietf@gmail.com,
 ast@kernel.org, hch@infradead.org, dthaler@microsoft.com,
 hawkinsw@obs.cr, jemarch@gnu.org, yonghong.song@linux.dev
Message-ID: <20231127201817.GB5421@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/SORPUCqpwU9nTOgqQVHnGRWf7qM>
Subject: [Bpf] IETF 118 BPF WG summary
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

Hello everyone,

We had a productive BPF working group meeting at IETF 118, and we wanted
to provide a summary to recap what was discussed.

*BPF ISA*

Dave Thaler provided an update on what's changed in the BPF ISA I-D
since IETF 117. Those changes included (but were not necessarily limited
to) the following:

- ABI-specific text was moved from this document into a separate ABI [0]
  document that has yet to be adopted into the WG.
- IANA considerations were added to the document:
        - Permanent: Standards action or IESG Review
        - Provisional: Specification required
        - Historical: Specification required
- For listing instructions in the IANA registry, it was decided to keep
  them as a single table with multiple key fields.
- New instructions (signed division, signed modulo, move with sign
  extension, load with sign extension, unconditional byte swap, and
  32-bit offset jumps) were added by Yonghong Song.
- A few other fixes and improvements provided by Will Hawkins, Jose
  Marchesi, and others.

After this update, the discussion moved to a topic for the BPF ISA
document that has yet to be resolved: ISA RFC compliance. Dave pointed
out that we still need to specify which instructions in the ISA are
MUST, SHOULD, etc, to ensure interoperability.  Several different
options were presented, including having individual-instruction
granularity, following the clang CPU versioning convention, and grouping
instructions by logical functionality.

We did not obtain consensus at the conference on which was the best way
forward. Some of the points raised include the following:

- Following the clang CPU versioning labels is somewhat arbitrary. It
  may not be appropriate to standardize around grouping that is a result
  of largely organic historical artifacts.
- If we decide to do logical grouping, there is a danger of
  bikeshedding. Looking at anecdotes from industry, some vendors such as
  Netronome elected to not support particular instructions for
  performance reasons.

Once this compliance question has been resolved, we expect that the ISA
document will be ready to move to WG last call.

*BPF Memory Model and psABI*

Alexei Starovoitov presented the rough outline of a proposal for the BPF
Memory Model, and clarified some of his views on the BPF psABI. The main
thrust of the proposal was that the BPF MM should reflect that of
hardware memory models such as ARM and x86, and be mirrored after the
LKMM (Linux Kernel Memory Model), of which language MMs are a strict
subset. Existing language MMs do not properly handle control
dependencies, and suffer from issues such as OOTA (Out-of-Thin-Air)
reads. The presentation outlined the control dependencies proposed for
various types of BPF instructions, such as atomics, jumps, etc.

Overall the proposal seemed well received, though the issue of whether
ABIs should be standardized was again resurfaced. When the WG was
formed, the expectation was that such conventions would be captured in
one or more Informational documents. This question will likely have to
be resolved before an I-D could be adopted.

*Conclusion*

This was another very productive session. It's clear that we're almost
ready to make a WG last call for the ISA document. Hopefully we can
resolve the issue of compliance quickly. It's also great to see that the
BPF MM and ABI standardization discussions are proceeding. It seemed
that we all had rough consensus on the proposal for the BPF MM, so it
would be great for us to get some of that written down into the existing
ABI document.

Have a wonderful week, and we look forward to more progress!

Best,
David and Suresh

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

