Return-Path: <bpf+bounces-3322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0273C3E4
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 00:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974C91C21360
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E01642F;
	Fri, 23 Jun 2023 22:18:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B506111AD
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 22:18:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B6172C;
	Fri, 23 Jun 2023 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XtULKguSVpdmkKV3+iJ4SzMacgpYrSQRmcI9xhs0U2k=; b=cNtnaZ1JBPeKNPmADijtyiZzmC
	l9HdzSRROXNXYT23UXuCv6B8/eSCxGs1XMudrtYV8qJOyQwn7Fso5j06z16v/UyhpKA+06cn14IHE
	3q2IwtuQ+55oB/3XzZQ66yuDHCnY57ZJ4WdfPR3ur0XUc2Xr5614iNKsPVHlCXnRuSJz+/1uzJNbh
	suCx2kfQhXUAX+f6cwxDvWdYHHfu+y5iR1mPP9rDVrI16CLmqxGsrh/RVQ0uq2F+7SviYOMcCZfzS
	csU3PjHha2Rh46KP4KCir31opF2S4v5ijbU+B4Di6rYkSbAS5BLIypBMQamYJ8RtVjmduqEUiw03e
	GeXpt/gA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCp6h-000Cfv-Db; Sat, 24 Jun 2023 00:18:19 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCp6g-000TlB-W1; Sat, 24 Jun 2023 00:18:19 +0200
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com, Sargun Dhillon <sargun@sargun.me>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
 <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com>
 <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com>
 <CAEf4BzaQSKBJ_+8HaHdBHa9_guL_QCVgHZHb6jpCqv6CboCniQ@mail.gmail.com>
 <CAEiveUdU7On9c27iek2rRmqSLFTKduNUtjEAD0iaCPQ4wZoH6Q@mail.gmail.com>
 <20230614-geruch-verzug-db3903a52383@brauner>
 <CAEf4BzawogpzENKC=KYk+mvc375ZF8Rs0gnu5grOywUsM0AV+Q@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8f291af1-a91f-4c6f-ee19-1998cdb7ce1d@iogearbox.net>
Date: Sat, 24 Jun 2023 00:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzawogpzENKC=KYk+mvc375ZF8Rs0gnu5grOywUsM0AV+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26948/Fri Jun 23 09:28:15 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/16/23 12:48 AM, Andrii Nakryiko wrote:
> On Wed, Jun 14, 2023 at 2:39 AM Christian Brauner <brauner@kernel.org> wrote:
>> On Wed, Jun 14, 2023 at 02:23:02AM +0200, Djalal Harouni wrote:
>>> On Tue, Jun 13, 2023 at 12:27 AM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>> On Mon, Jun 12, 2023 at 5:02 AM Djalal Harouni <tixxdz@gmail.com> wrote:
>>>>> On Sat, Jun 10, 2023 at 12:57 AM Andrii Nakryiko
>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>> On Fri, Jun 9, 2023 at 3:30 PM Djalal Harouni <tixxdz@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Andrii,
>>>>>>>
>>>>>>> On Thu, Jun 8, 2023 at 1:54 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>>>>>>>>
>>>>>>>> ...
>>>>>>>> creating new BPF objects like BPF programs, BPF maps, etc.
>>>>>>>
>>>>>>> Is there a reason for coupling this only with the userns?
>>>>>>
>>>>>> There is no coupling. Without userns it is at least possible to grant
>>>>>> CAP_BPF and other capabilities from init ns. With user namespace that
>>>>>> becomes impossible.
>>>>>
>>>>> But these are not the same: delegate full cap vs delegate an fd mask?
>>>>
>>>> What FD mask are we talking about here? I don't recall us talking
>>>> about any FD masks, so this one is a bit confusing without more
>>>> context.
>>>
>>> Ah err, sorry yes referring to fd token (which I assumed is a mask of
>>> allowed operations or something like that).
>>>
>>> So I want the possibility to delegate the fd token in the init userns.
>>>
>>>>>
>>>>> One can argue unprivileged in init userns is the same privileged in
>>>>> nested userns
>>>>> Getting to delegate fd in init userns, then in nested ones seems logical...
>>>>
>>>> Again, sorry, I'm not following. Can you please elaborate what you mean?
>>>
>>> I mean can we use the fd token in the init user namespace too? not
>>> only in the nested user namespaces but in the first one? Sorry I
>>> didn't check the code.
>>>
> 
> [...]
> 
>>>
>>>>> Having the fd or "token" that gives access rights pinned in two
>>>>> separate bpffs mounts seems too much, it crosses namespaces (mount,
>>>>> userns etc), environments setup by privileged...
>>>>
>>>> See above, there is nothing namespaceable about BPF itself, and BPF
>>>> token as well. If some production setup benefits from pinning one BPF
>>>> token in multiple places, I don't see the problem with that.
>>>>
>>>>>
>>>>> I would just make it per bpffs mount and that's it, nothing more. If a
>>>>> program wants to bind mount it somewhere else then it's not a bpf
>>>>> problem.
>>>>
>>>> And if some application wants to pin BPF token, why would that be BPF
>>>> subsystem's problem as well?
>>>
>>> The credentials, capabilities, keyring, different namespaces, etc are
>>> all attached to the owning user namespace, if the BPF subsystem goes
>>> its own way and creates a token to split up CAP_BPF without following
>>> that model, then it's definitely a BPF subsystem problem...  I don't
>>> recommend that.
>>>
>>> Feels it's going more of a system-wide approach opening BPF
>>> functionality where ultimately it clashes with the argument: delegate
>>> a subset of BPF functionality to a *trusted* unprivileged application.
>>> My reading of delegation is within a container/service hierarchy
>>> nothing more.
>>
>> You're making the exact arguments that Lennart, Aleksa, and I have been
>> making in the LSFMM presentation about this topic. It's even recorded:
> 
> Alright, so (I think) I get a pretty good feel now for what the main
> concerns are, and why people are trying to push this to be an FS. And
> it's not so much that BPF token grants bpf() syscall usage to unpriv
> (but trusted) workloads or that BPF itself is not namespaceable. The
> main worry is that BPF token, once issues, could be
> illegally/uncontrollably passed outside of container, intentionally or
> not. And by having this association with mount namespace (through BPF
> FS) we automatically limit the sharing to only contain that has access
> to that BPF FS.

+1

> So I agree that it makes sense to have this mount namespace
> association, but I also would like to keep BPF token to be a separate
> entity from BPF FS itself, and have the ability to have multiple
> different BPF tokens exposed in a single BPF FS instance. I think the
> latter is important.
> 
> So how about this slight modification: when a BPF token is created
> using BPF_TOKEN_CREATE command, the user has to provide an FD for
> "associated" BPF FS instance (superblock). What that does is allows
> BPF token to be created with BPF FS and/or mount namespace association
> set in stone. After that BPF token can only be pinned in that BPF FS
> instance and cannot leave the boundaries of that mount namespace
> (specific details to be worked out, this is new area for me, so I'm
> sorry if I'm missing nuances).

Given bpffs is not a singleton and there can be multiple bpffs instances
in a container, couldn't we make the token a special bpffs mount/mode?
Something like single .token file in that mount (for example) which can
be opened and the fd then passed along for prog/map creation? And given
the multiple mounts, this also allows potentially for multiple tokens?
In other words, this is already set up by the container manager when it
sets up mounts rather than later, and the regular bpffs instance is sth
separate from all that. Meaning, in your container you get the usual
bpffs instance and then one or more special bpffs instances as tokens
at different paths (and in future they could unlock different subset of
bpf functionality for example).

Thanks,
Daniel

