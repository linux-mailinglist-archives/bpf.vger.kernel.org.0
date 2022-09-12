Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB85B5754
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiILJnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiILJnR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 05:43:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC527CC6;
        Mon, 12 Sep 2022 02:43:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso10601853wmc.0;
        Mon, 12 Sep 2022 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=v9fqEBVLV5iKy/G2Bt6vR6zJk2p8sIIWJSHXdeCUN1s=;
        b=kIeYUPvDeV3L0Ro9OdON4Zmv0MbYRKR9sTDCa3GD3DboeJaj4C37LnP+h4KRJkdjFw
         231QRbFJZFg9Pcvpv8L22ik4gIQlwKD2AUNZAtNGtBlP63fa0631zj+DdlzpfMP4fvhm
         4mSLhuhzcdJm7oZn666Z1lfAoul29ZqmvALzImJp/XS/8ND0+QnEryo5aKzUW7Irmgo+
         DywnByjG8XSCKzTqwfrphDqevo5H1iBULB444PwwNDOmRsUtHtpyJkZIwOybiGWdXaN3
         gRlfrNV30KGiNrQFMwfwIYU28bKw+BzlQsdM2o5G44lNY5CuGFW854gIBnm0mKGI2vJj
         U6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=v9fqEBVLV5iKy/G2Bt6vR6zJk2p8sIIWJSHXdeCUN1s=;
        b=eH7EGwb8GFgJu82U6hbfIeq7sLW6d0YvwCiyFuCtYkoCJv6950eAmde1jIlsa84+Ny
         fQOKeVQXykWgxkW7MdRfEUOx2rvMuVDX283yuW+iuu8PfWByc4iWdS42Le2Vtt9ae9e0
         RAXYXMsJZEP+aF8oVGJCm/xtEiLPuDPXpXo6bT+bpArp10+z8W1gjrZYGZr+wWVFcJmR
         ijyoF+uPkD5zr6+2YKy4snBIk+M07xqMg07ZvP86YEwRAs9SGyOnwCh9pI9iZI+Wbcj8
         IH0CQnmJ9yO70vGz9yOEjx4wtzrTykPl0+sRTGqp0VfHNW4O74HJAh+C1aSlA50ZVy/J
         PEOg==
X-Gm-Message-State: ACgBeo2nYv4OCoe5E4BMrJ4fnESXCuW1y6cxF/Qk+8Beo+2+2W34UJ8R
        0nAsd49Ie2Su/OwEXAHEHeQ=
X-Google-Smtp-Source: AA6agR5XgB7miHJ7dy/o6yB5sM8VyivrnHoVunGowNiZkzJ7q6rHS5zoqsCVBqyxxyv9ye1jJg40EQ==
X-Received: by 2002:a05:600c:34c2:b0:3b4:76f2:9c3b with SMTP id d2-20020a05600c34c200b003b476f29c3bmr4628234wmq.179.1662975794282;
        Mon, 12 Sep 2022 02:43:14 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a19a:6418:7e1e:227a])
        by smtp.gmail.com with ESMTPSA id k9-20020adfb349000000b002252884cc91sm6963635wrd.43.2022.09.12.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:43:13 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v3 1/2] Add subdir support to Documentation
 makefile
In-Reply-To: <20220909214914.hdn4rxsj6b2cy3xj@muellerd-fedora-PC2BDTX9>
        ("Daniel =?utf-8?Q?M=C3=BCller=22's?= message of "Fri, 9 Sep 2022 21:49:14
 +0000")
Date:   Mon, 12 Sep 2022 09:31:55 +0100
Message-ID: <m235cx2dtw.fsf@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
        <20220829091500.24115-2-donald.hunter@gmail.com>
        <3d08894c-b3d1-37e8-664e-48e66dc664ac@iogearbox.net>
        <m2h71k6bw8.fsf@gmail.com>
        <CAEf4BzZ_2wCVTjhAe0XzJ5qfbVhV0pfZeJ=z9Jg_fj_fzD1JFw@mail.gmail.com>
        <m2bkro3lh5.fsf@gmail.com>
        <20220909214914.hdn4rxsj6b2cy3xj@muellerd-fedora-PC2BDTX9>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel M=C3=BCller <deso@posteo.net> writes:

> On Fri, Sep 09, 2022 at 11:12:22AM +0100, Donald Hunter wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>=20
>> > On Tue, Sep 6, 2022 at 3:50 AM Donald Hunter <donald.hunter@gmail.com>=
 wrote:
>> >>
>> >> Daniel Borkmann <daniel@iogearbox.net> writes:
>> >>
>> >> > On 8/29/22 11:14 AM, Donald Hunter wrote:
>> >> >> Run make in list of subdirs to build generated sources and migrate
>> >> >> userspace-api/media to use this instead of being a special case.
>> >> >> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> >> >
>> >> > Jonathan, given this touches Documentation/Makefile, could you ACK =
if
>> >> > it looks good to you? Noticed both patches don't have doc: $subj pr=
efix,
>> >> > but that's something we could fix up.
>> >> >
>> >> > Maybe one small request, would be nice to build Documentation/bpf/l=
ibbpf/
>> >> > also with every BPF CI run to avoid breakage of program_types.csv. =
Donald
>> >> > could you check if feasible? Follow-up might be ok too, but up to A=
ndrii.
>> >>
>> >> Sure, I can look at what is needed for the BPF CI run.
>> >>
>> >
>> > Daniel (Mueller, not Borkmann), is this something that can be added to=
 BPF CI?
>
> I think as long as all required packages are available in the CI distribu=
tion
> (which I believe is currently a Ubuntu image, but may in the future becom=
e Arch
> Linux) it should not be a problem to perform checking in CI. It seems as =
if
> generating the documentation may take a while, so we should likely try to=
 have
> it run in a separate job. I can't tell what hidden dependencies there may=
 be,
> though.
>
>> It looks to me like it can be added to BPF CI if we change docs/conf.py
>> to call a new make target in docs/sphinx/Makefile. Hopefully Daniel can
>> confirm whether this is the case.
>
> I am not familiar with the documentation generation, but my quick search =
seems
> to suggest that this is done by a 3rd party service and is decoupled from=
 BPF
> CI. Specifically, what you suggest may be reflected in the generated docs=
 at
> https://libbpf.readthedocs.io/, but I believe they are created from the l=
ibbpf
> GitHub repository, which is only infrequently synced from bpf tree source=
s. I
> didn't find any indication that CI triggers documentation creation, but i=
t's
> possible I missed something.

Apologies, I was referring to the libbpf GitHub repository. Anything
committed to the kernel Documentation/bpf/libbpf risks breaking the
documentation generation in the libbpf GitHub repository which, as you
say, uses readthedocs.
