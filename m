Return-Path: <bpf+bounces-5272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B777592D0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 12:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B4B1C20E23
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657112B74;
	Wed, 19 Jul 2023 10:24:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0811CB4
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 10:24:23 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FF0210C
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 03:24:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so6703276f8f.3
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689762238; x=1692354238;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pB83+GzxB3ZKgy0olUmuYXmLTEyksF3hnZFoHWfOjC0=;
        b=NcpQ2eRPoM6T4+ifrk6SaW/JbupUaNiHhYsHfY9CBjDgiKbapBvLKVaGUnipHild81
         gYK+4EYyYJQtUeREkoSIBflaq3763SeeE7EnFzOSjIHHVB+Np9K1nCWKi4VTZryS94XP
         IXerwtG/DMoGUPxPYqH5Qrt8a2Hzk3mMFWuaebVfS9DOfg9Be3JDUJltR4Y1uTzxU3Gs
         LxeOTAuEWFUx7a19o6+HkWpnCVNPRz010HIJBOSSuJzce1MTu6DNiXe6KdTdjKZU1yXx
         MxW8iHgRreiwLYN+to14wypuICK9IHFqygv9YFaUxYzcRUCCZOO+0BEoVX/AMBvY7asn
         Eahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762238; x=1692354238;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pB83+GzxB3ZKgy0olUmuYXmLTEyksF3hnZFoHWfOjC0=;
        b=XKxnWHbhuQGfPC7zA4KhJ65XpPjlEXl5oL35bXWTz3jri2ZbKPnEtTEK/JKs7wfvoI
         fJjuLBnsqOSq6H/F1jfPZFxOYsP7i6RDXYPyNO3aIwf+ljx/MCOXSg0+Zsm+j71b3f8J
         QJyNADU3hawr0Qjt07PVnphRGkHJ5pdHMfE1M5kJivsGBkMevx8bECnsgTzv09mpPmhu
         3AqIQD3ZO04qGlZNDpIv+8VR6a0G1JnTTJp2d7+6hIu6B4+sa7/+R6UdKIro/jhTObCK
         /LWXjFsCMscr735qhVzcIlsHImmL2MrG+G8COMzELqWrolgkooQvaj2IYoSpSYEuDvbu
         3Y1Q==
X-Gm-Message-State: ABy/qLZ883YvNk3UTMsHaipDjCDMqtuotQOXieKiVaHaOhE8eHvBSso8
	w2j/elakKcyWLsDNxnpKLmdbI6CCMB8=
X-Google-Smtp-Source: APBJJlFoSPWlLiVjd0/GQBOWPweoQ3uDSEjnJLr6NQcuNRSzFcRqp61uRquYVR8coirsLtVx58LW0Q==
X-Received: by 2002:a5d:430e:0:b0:313:e8bf:a6e with SMTP id h14-20020a5d430e000000b00313e8bf0a6emr1667404wrq.21.1689762237763;
        Wed, 19 Jul 2023 03:23:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e9ba:5476:10bb:8cae])
        by smtp.gmail.com with ESMTPSA id k15-20020a056000004f00b003143ba62cf4sm4885520wrx.86.2023.07.19.03.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 03:23:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Barret Rhoden <brho@google.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  bpf
 <bpf@vger.kernel.org>
Subject: Re: Repo for tips / tricks / common code?
In-Reply-To: <CAADnVQ+MtUZ27vjMnXbFG33j15ZV2FdZgpe4tcDrwXgmp41nxQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 18 Jul 2023 15:17:02 -0700")
Date: Wed, 19 Jul 2023 10:51:12 +0100
Message-ID: <m2cz0oz0tr.fsf@gmail.com>
References: <1d6b05aa-f7c1-84ca-645a-f872813ca76f@google.com>
	<CAADnVQ+MtUZ27vjMnXbFG33j15ZV2FdZgpe4tcDrwXgmp41nxQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jul 18, 2023 at 9:15=E2=80=AFAM Barret Rhoden <brho@google.com> w=
rote:
>>
>> Hi -
>>
>> Is there any interest in a repo or something for reusable BPF code bits?
>>   I've got some stuff that I do in my programs that might be useful to
>> others, but not to the level of a full bpf helper.
>>
>> For instance, one technique I've developed is to have list-like data
>> structures for *mmappable* data that are e.g. per-cpu and per-task.
>> Internally, it's an Array map, and each element is identified by its
>> index in the array instead of by point.  And the linked-list is built
>> with index integers instead of pointers.
>>
>> Anyway, that's just an example, and I imagine other people have their
>> own techniques.  I've got the code sitting in an open-source repo
>> elsewhere, and had a couple people off-list ask me about it.  I could
>> email it to the list, but it'd get lost in the noise.
>>
>> If you're curious about specifics, the linked list code is here [1], and
>> I briefly mentioned the data structures in my LPC 22 talk [2].  I've got
>> an AVL tree that works with this stuff too.
>
> I think github would be the best place for such code.
> https://github.com/libbpf/.../ maybe?

Or potentially:

https://github.com/xdp-project/bpf-examples

>
>> Thanks,
>> Barret

