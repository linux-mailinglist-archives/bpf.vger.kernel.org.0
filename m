Return-Path: <bpf+bounces-4048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B936748444
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1861C20B41
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37916AB1;
	Wed,  5 Jul 2023 12:35:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5946BD
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 12:35:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A153172B
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688560473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9n2Chuvyr5F1WS1DcynjB5EgkPOLdfP7pefN+jTsGUk=;
	b=gmNCbHJOc1zVfaMIYzmSR+vTtk9kDBDQf+SbfRlggBWeTZuNUCu5eEjKvjBo10ytd5CiTR
	6TrpUaDHV67msm2ePWuCvYddSQthBAgjsvKhe5+H5iuamH8hfPKI4GORFyInWsNGwT2c/k
	UedUElOg94VAIqshKwo1/H7yY7WDUPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-PalxPpxyMFC8LtLfbuBw5A-1; Wed, 05 Jul 2023 08:34:32 -0400
X-MC-Unique: PalxPpxyMFC8LtLfbuBw5A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31432b25c2fso3257104f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 05:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688560471; x=1691152471;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n2Chuvyr5F1WS1DcynjB5EgkPOLdfP7pefN+jTsGUk=;
        b=XJtnEDiacoa65N8vrNRAdoFhifPYLhkrRGLVAZURBEHDWSYuwR7jTS7VkKSc9PF9cF
         b2aHCTXW1MgjMdGCC+EDl+0g558BgmsoPg0risRtZbcdp+S7g49wdqI56GQ4w1R8Q/V7
         0/hHOTijUGchn14iX0TrU8JaHI0M5Cakx7SUmWpuXsaNVtDZlm2c6MdKvR7azGFrwofr
         KeBL4TPMnenbDIIbPch+QFjz0d0PBHoZofDatPU3WLUhoSUJF0P6Tw8/09JiByt5mkMB
         6flank2jr20r5xzEQSO8d4RhbJrw+vdZggoVUhRG9MDnPiY65RDocWF1UEUxivx099fx
         IjBA==
X-Gm-Message-State: ABy/qLZAwUUrY0cfmmYNeBP5kgqyxpROpss5AuLU2bphsERNb10vuh6y
	9Y6WqbhiOMiTPHl+geRNUAad0ykfkqI7mGCe4mi9fgm2hsR1K9/HLWASmjObO1o8EeVV6oksWYM
	mihDqCRuMu6E5
X-Received: by 2002:adf:e4c1:0:b0:314:37ac:c896 with SMTP id v1-20020adfe4c1000000b0031437acc896mr11965185wrm.44.1688560470640;
        Wed, 05 Jul 2023 05:34:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVDjX0j2vlDhMrqZgyZuPY4mV1tg2k5iuAkbToYRMjihI+/Ew0efXto7iasHFqX3KI860e1Q==
X-Received: by 2002:adf:e4c1:0:b0:314:37ac:c896 with SMTP id v1-20020adfe4c1000000b0031437acc896mr11965158wrm.44.1688560470123;
        Wed, 05 Jul 2023 05:34:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d5144000000b0031444673643sm2704145wrt.57.2023.07.05.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 05:34:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA5FEBC12F0; Wed,  5 Jul 2023 14:34:28 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Christian Brauner <brauner@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
 kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <20230705-praxen-nahmen-644ea9e5c35c@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <87sfa3b6j5.fsf@toke.dk>
 <3555c0bd-7aee-35b0-655d-710437b4876c@iogearbox.net>
 <20230705-praxen-nahmen-644ea9e5c35c@brauner>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jul 2023 14:34:28 +0200
Message-ID: <87h6qibkq3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Jul 05, 2023 at 09:20:28AM +0200, Daniel Borkmann wrote:
>> On 7/5/23 1:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Christian Brauner <brauner@kernel.org> writes:
>> > > On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
>> > > > Add new kind of BPF kernel object, BPF token. BPF token is meant t=
o to
>> > > > allow delegating privileged BPF functionality, like loading a BPF
>> > > > program or creating a BPF map, from privileged process to a *trust=
ed*
>> > > > unprivileged process, all while have a good amount of control over=
 which
>> > > > privileged operations could be performed using provided BPF token.
>> > > >=20
>> > > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, whi=
ch
>> > > > allows to create a new BPF token object along with a set of allowed
>> > > > commands that such BPF token allows to unprivileged applications.
>> > > > Currently only BPF_TOKEN_CREATE command itself can be
>> > > > delegated, but other patches gradually add ability to delegate
>> > > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
>> > > >=20
>> > > > The above means that new BPF tokens can be created using existing =
BPF
>> > > > token, if original privileged creator allowed BPF_TOKEN_CREATE com=
mand.
>> > > > New derived BPF token cannot be more powerful than the original BPF
>> > > > token.
>> > > >=20
>> > > > Importantly, BPF token is automatically pinned at the specified lo=
cation
>> > > > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_=
PIN
>> > > > command, unlike BPF prog/map/btf/link. This provides more control =
over
>> > > > unintended sharing of BPF tokens through pinning it in another BPF=
 FS
>> > > > instances.
>> > > >=20
>> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> > > > ---
>> > >=20
>> > > The main issue I have with the token approach is that it is a comple=
tely
>> > > separate delegation vector on top of user namespaces. We mentioned t=
his
>> > > duringthe conf and this was brought up on the thread here again as w=
ell.
>> > > Imho, that's a problem both security-wise and complexity-wise.
>> > >=20
>> > > It's not great if each subsystem gets its own custom delegation
>> > > mechanism. This imposes such a taxing complexity on both kernel- and
>> > > userspace that it will quickly become a huge liability. So I would
>> > > really strongly encourage you to explore another direction.
>> >=20
>> > I share this concern as well, but I'm not quite sure I follow your
>> > proposal here. IIUC, you're saying that instead of creating the token
>> > using a BPF_TOKEN_CREATE command, the policy daemon should create a
>> > bpffs instance and attach the token value directly to that, right? But
>> > then what? Are you proposing that the calling process inside the
>> > container open a filesystem reference (how? using fspick()?) and pass
>> > that to the bpf syscall? Or is there some way to find the right
>> > filesystem instance to extract this from at the time that the bpf()
>> > syscall is issued inside the container?
>>=20
>> Given there can be multiple bpffs instances, it would have to be similar
>> as to what Andrii did in that you need to pass the fd to the bpf(2) for
>> prog/map creation in order to retrieve the opts->abilities from the super
>> block.
>
> I think it's pretty flexible what one can do here. Off the top of my
> head there could be a dedicated file like /sys/fs/bpf/delegate which
> only exists if delegation has been enabled. Thought that might be just a
> wasted inode. There could be a new ioctl() on bpffsd which has the same
> effect.
>
> Probably an ioctl() on the bpffs instance is easier to grok. You could
> even take away rights granted by a bpffs instance from such an fd via
> additional ioctl() on it.

Right, gotcha; I was missing whether there was an existing mechanism to
obtain this; an ioctl makes sense. I can see the utility in attaching
this to the file system instance instead of as a separate object that's
pinned (but see my post in the other subthread about using the "ask
userspace model instead").

-Toke


