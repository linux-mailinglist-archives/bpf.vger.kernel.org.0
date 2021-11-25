Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F445D480
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 07:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbhKYGGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 01:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbhKYGEl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 01:04:41 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2DC061574;
        Wed, 24 Nov 2021 22:00:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id f20so5158282qtb.4;
        Wed, 24 Nov 2021 22:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t+yyWN3NnkiYOkpDcW6wXNJGv8udDGL/BSC5HOvefek=;
        b=CrFqKTv/vO8VYObhtq80BD65+iqDDpy28e0145ShIt3ZqKH6T5xT/xhe1RV/UWyvQM
         wJkSMFjNf5ebnfJrICt8+9zui4ct6jaZzEPEZsYoeBCHCcQMvEuTDpLWapJijrYlWcWk
         Ks9djLhf/NnaKUE+HzJNSc3mBm3QSSv54OtJLspX6+WXXlVSi25BE6pdghxZTA8vu+QT
         fAy4CUJpeB/DzB0E6Ktg0qqEkxseihU1OX4H66Ulb2XKB+we824sbIqvtGi1AEC59BOZ
         F7TzMTQ0G1mqw2g9soGnVqmu6GIbUmmUbT6fLuHPzxtOlflt2bBdOP25qXT5mDtF3RUh
         0MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t+yyWN3NnkiYOkpDcW6wXNJGv8udDGL/BSC5HOvefek=;
        b=gXzR5aevYW04orUILstMdHlxwKitqOcSMdnTd6e3ISS3YHOx7tpXuvvXLbL46koSaO
         rfQoF/wyeABOJ8XooqzIu9QO5N17K/cciHZBX0iLXITnGl3RTMfOn6SE2TTjodrM+v3t
         EFGhKijgZBYaQpVepXcQr3kbsq2vTPHnYYLWJE37zEdqCUWCcWSOCy8jW/hCCSDWZBlo
         iUm8hFfslftKYx4eRS7s3LUu07FElp7dFSwoX2lrpXgOYC8UgQ+U97wFo4o7Lmb9tV9H
         Sw3i9Gr+9r+oPI1krhtXVCxNJhttatE9NuHZf4Nl60JIhYkYaLrk5iMi1S7ZtwovNzk2
         RGRA==
X-Gm-Message-State: AOAM533lqbClDzGlejKCAVzgeaw/AUo7QdR0qGVinNCr5Nb5Z2i3e/QO
        pjzhW/kMbSpJHLU1RmlAV+vsPTZPlmIbnKAwxTg=
X-Google-Smtp-Source: ABdhPJwNW/8Jzygtcv8FN5ZAz7jujmg3uEGc3DDpRjxhTlL/THJoKRoxEqj4c5cBnXBQ+8LXeunB2ie9lLNOQgD/VbA=
X-Received: by 2002:ac8:5f89:: with SMTP id j9mr14079256qta.391.1637820040521;
 Wed, 24 Nov 2021 22:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20210915213550.3696532-1-guro@fb.com> <20210916162451.709260-1-guro@fb.com>
 <52EC1E80-4C89-43AD-8A59-8ACA184EAE53@gmail.com>
In-Reply-To: <52EC1E80-4C89-43AD-8A59-8ACA184EAE53@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 25 Nov 2021 14:00:04 +0800
Message-ID: <CALOAHbC0xNnqWt=og+g=DT0yRqST6cTAUvZkQ-7o8Nw8O-2J9w@mail.gmail.com>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
To:     Roman Gushchin <guro@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roman,

Scheduler BPF is a great idea.
Thanks for the work.

Scheduler BPF won=E2=80=99t be a small feature,  I think we=E2=80=99d bette=
r give a
summary of possible hooks it may add first.
We must have a *basic rule* to control what it will tend to be to
avoid adding BPF hooks here and there.
I haven=E2=80=99t found a clear rule yet, but maybe we can learn it from
netfilter, which has 5 basic hooks.
Regarding the scheduler BPF hooks, some possible basic hooks may be:
  - Hook for Enqueue
  - Hook for Dequeue
  - Hook for Put Prev Task
   - Hook for Set Next Task


> An example of an userspace part, which loads some simple hooks is availab=
le
> here [3]. It's very simple, provided only to simplify playing with the pr=
ovided
> kernel patches.
>

You=E2=80=99d better add this userspace code into samples/bpf/.


[Some error occurs in my mail client, so I resend it]


--
Thanks
Yafang
