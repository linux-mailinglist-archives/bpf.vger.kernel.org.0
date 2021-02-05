Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F21B310417
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 05:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBEEfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 23:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBEEfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 23:35:08 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578DC0613D6;
        Thu,  4 Feb 2021 20:34:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t63so5809212qkc.1;
        Thu, 04 Feb 2021 20:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=NOLcDzmq84OpsF0OUOcDHrS75Pek3eO6qwDBNOLFWTM=;
        b=HJcL399K1cDxGgOSWivkYeAapPU3evPA+sc3gZgiaSdy3thVI4Y16LSPcT6AHe3C0d
         GBUhN8Kv7yO2cYOoUBfEXdf6dF4RT+0ruX7XGBs0T2oAUwjX8M2VLeN2JH5d8kZF0MCo
         GXGoIVHyNcOSCKkyZ/dpgxMksWc8xwybO+0UGTZ4/fWXwsp9hrY0LTMhg71i/tpMtEim
         FMtSAVVrJMlPdA0ASdBZUN2ppVa3xyh9HS+0xbfiJr+i8oOYAwZUjZxOKYbIuOD1o6WR
         pq/GThN9R1712H5et8MkqtuGtEINGESMOXXGhClbtkyHThBsew4EFoTSMnK0uc5F7FrJ
         kCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=NOLcDzmq84OpsF0OUOcDHrS75Pek3eO6qwDBNOLFWTM=;
        b=H6DS9GkNg+cduPmyX/ocSh4qHY6cQ/rhFtrMkss3netoNBDoUyXWvw69ByCdFjKZ+3
         KJukm5t/p87pgWhHZOUJuEo7BhdnFGx+sbS/PtiBYgJsrdBnz34ToiIrOG2xqlmKVSao
         VN/Ofklntbp1K4KUHgMNcWppMKcDl9qdOPub5SWX4Gw626bZvWp9JhUmE9WAftF83PoN
         fsokqcUu26TL3Eqy7NyP2huMMa336txc8n7UKrYz/1ly+vMUyn6RvTnLGDJxyLNDeG5d
         /Vtrk02xJqYfCQJLI+nF7UM6Gy1e9HQ6nqqG0y8TlarMm+8PyobUdI3Kz+HC4FjZKnWO
         d0Xw==
X-Gm-Message-State: AOAM5319cxtYIByGZCh58OXgZQaSdjRGKWm56QTgxx7rCjZoFuOJsOtN
        uLfmqD9tyB+UNZPEwzPitaw=
X-Google-Smtp-Source: ABdhPJzl1quRaNScBCHyO298sF5rSWQjh4wYJrZNpFEbsutRtV9GeHaOufCnHGcM53q3uMHNvDxqBg==
X-Received: by 2002:a37:a0c6:: with SMTP id j189mr2745942qke.374.1612499665961;
        Thu, 04 Feb 2021 20:34:25 -0800 (PST)
Received: from [192.168.86.198] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id z23sm3527081qkb.13.2021.02.04.20.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 20:34:25 -0800 (PST)
Date:   Fri, 05 Feb 2021 01:33:13 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
References: <20210204220741.GA920417@kernel.org> <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF sections, BTF)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On February 4, 2021 9:01:51 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakryi=
ko@gmail=2Ecom> wrote:
>On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de Melo><acme@kernel=2Eor=
g> wrote:
>>         The v1=2E20 release of pahole and its friends is out, mostly
>> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
>> available at the usual places:
>
>Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?

It's in rawhide already, I'll do it for f33, f32 later,

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
