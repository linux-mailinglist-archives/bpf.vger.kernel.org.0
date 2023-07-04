Return-Path: <bpf+bounces-4007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4BE747A5E
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 01:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94906280F3A
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265558460;
	Tue,  4 Jul 2023 23:28:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FB36C
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 23:28:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744AAE7A
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688513329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxr5qDhLUP1R94cKfvkuJwjykxCSB++k75bbVZUeq/M=;
	b=SLzNur6spbLIjlHw+/0m9E+OY8TVikilAnhrjIYVE5Y4NSvSjb/37/8WFMZqJpq/JN/VKX
	1rNvdjMZyTEhk8QWftsvDWaTjgynR4FjYnU2XX2rH9bJoryke7sCLOgBW2YewF1X0e/rSq
	7ahfSDqM+0WPc+OBBn7kr2k8ke3RYzU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-B6RU4C7EN3GRTnRXy2MHGQ-1; Tue, 04 Jul 2023 19:28:48 -0400
X-MC-Unique: B6RU4C7EN3GRTnRXy2MHGQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9928b8f54a0so407834166b.2
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 16:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513327; x=1691105327;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxr5qDhLUP1R94cKfvkuJwjykxCSB++k75bbVZUeq/M=;
        b=LASIM6Yl0GieH0PKGmvEvbLyFduOEgeVSIiaw2nO41fpl+6wxej5QjLqDd26VDvPC8
         yTacilmBQswN5sy1u99IpzLe42LKk86OKNtWRbLez6GP/WofCDePzuvucdnJX3FbQV4z
         BotfksE+ek+ZSBf+4NoRgSOuQxR6rm5Nvw5qUyHVUgsck1e42t1mH8qRtVIAJqv+65zZ
         79srapc+uGTVZHQhu7XVkCHDqyqtfJCn6FajtbzqlmyPP5giO+a0z1n0tAnpimEBk2I1
         6ViA5RshpnQS+AFj+Dl9C38oW7GXXOpHYa21sqsiiGupVS/pqfBJ1RsXIKln2Z6G+w/h
         BRaA==
X-Gm-Message-State: ABy/qLYabX+1H1FG/EQguYim6mZI45c4G+o7YUTO4FZTtGy4f+vyFAc+
	AKG1XLwSK1DS5rDZYeo9VjrKmh2z5vrD7VawzxmRiUngY2lB8/BTOQcz0JeMdPhdJ3ZJFVe2ag4
	p+lgZVu4TfHR9
X-Received: by 2002:a17:906:e94:b0:96a:30b5:cfb0 with SMTP id p20-20020a1709060e9400b0096a30b5cfb0mr10566095ejf.22.1688513327457;
        Tue, 04 Jul 2023 16:28:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFuT5Cw7eJvulDmFtlZ+cxEOXMoAhOur4BWAz8dQeBJFF/QKG4IKBkNPZT81R3Z2tSgFV60Mg==
X-Received: by 2002:a17:906:e94:b0:96a:30b5:cfb0 with SMTP id p20-20020a1709060e9400b0096a30b5cfb0mr10566080ejf.22.1688513327027;
        Tue, 04 Jul 2023 16:28:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id kg13-20020a17090776ed00b009932528281bsm5167763ejc.121.2023.07.04.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:28:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1EE49BC1180; Wed,  5 Jul 2023 01:28:46 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Christian Brauner <brauner@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jul 2023 01:28:46 +0200
Message-ID: <87sfa3b6j5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
>> Add new kind of BPF kernel object, BPF token. BPF token is meant to to
>> allow delegating privileged BPF functionality, like loading a BPF
>> program or creating a BPF map, from privileged process to a *trusted*
>> unprivileged process, all while have a good amount of control over which
>> privileged operations could be performed using provided BPF token.
>> 
>> This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
>> allows to create a new BPF token object along with a set of allowed
>> commands that such BPF token allows to unprivileged applications.
>> Currently only BPF_TOKEN_CREATE command itself can be
>> delegated, but other patches gradually add ability to delegate
>> BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
>> 
>> The above means that new BPF tokens can be created using existing BPF
>> token, if original privileged creator allowed BPF_TOKEN_CREATE command.
>> New derived BPF token cannot be more powerful than the original BPF
>> token.
>> 
>> Importantly, BPF token is automatically pinned at the specified location
>> inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
>> command, unlike BPF prog/map/btf/link. This provides more control over
>> unintended sharing of BPF tokens through pinning it in another BPF FS
>> instances.
>> 
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>
> The main issue I have with the token approach is that it is a completely
> separate delegation vector on top of user namespaces. We mentioned this
> duringthe conf and this was brought up on the thread here again as well.
> Imho, that's a problem both security-wise and complexity-wise.
>
> It's not great if each subsystem gets its own custom delegation
> mechanism. This imposes such a taxing complexity on both kernel- and
> userspace that it will quickly become a huge liability. So I would
> really strongly encourage you to explore another direction.

I share this concern as well, but I'm not quite sure I follow your
proposal here. IIUC, you're saying that instead of creating the token
using a BPF_TOKEN_CREATE command, the policy daemon should create a
bpffs instance and attach the token value directly to that, right? But
then what? Are you proposing that the calling process inside the
container open a filesystem reference (how? using fspick()?) and pass
that to the bpf syscall? Or is there some way to find the right
filesystem instance to extract this from at the time that the bpf()
syscall is issued inside the container?

-Toke


