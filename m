Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B686686DEE
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 19:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBAS2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 13:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBAS2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 13:28:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189382BEF0
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 10:28:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h12so18162085wrv.10
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2/lTthHiojeSCwIZDM/G8q6MV/KeNCrWe6Mx4THvH9U=;
        b=p7MA5jMcskM+OpPS16tMl+eSmEutIzPkSEtuh+YEr0HrKOWybEPOGG+gO9DaiXOAaZ
         ZYAwiXhAuVRWf4kD8dh3zKfxK0UO8YyTZxXNr4YKCc5Xb7qcXoqsYQZMaUsN3wjaJPYP
         f7Hvl4mIDzEac61AEboHeYQywpBVXB+0gH7+jVPxI2xUzrTDk29YFSvuArOic+N/dUq6
         xOtWyEPY/U+RkoISkAyZSwz1YSJ2qd65dbUv0rPrqmy+0/n5EVbQePTXG8nR8YleDEF4
         4dL3T2UNcA/stNb6guUIBhWQ7LxD/R7JfCvUJiY1GsX984ioqb7KlfZ55Z/sYYzXx463
         HEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/lTthHiojeSCwIZDM/G8q6MV/KeNCrWe6Mx4THvH9U=;
        b=EPnB5eBebdwPyG+DRSBbKFOT9SAsyPc2w4aq+daEpVV5OC6QXxgG3NhEXZX0M4yU/Q
         m5aJmF8yrQ3RgusEMWACWOI/qGavu4hbN+dmt50p3ytqJxWQpXlZfXuyWICi8roN6Ped
         B1psph4pXTDNFET0k3MAjDg1QLkmg2OSwz/rKCtzro18tyv0PSnFJMXcEU3Z4fQjTL1f
         TxUMtvUtA/3e0zvkWNUdKinAtzQb/hKch6PEGDuYSOQDv/OY/XTVhRZZk0JgWRW3g6fs
         n/VWp4JidXZYLIsUVztAhjcpyXybx8nOyFffE2zihkaaGNTcNDUar+1ee7v9Tp4dfB2v
         0lPQ==
X-Gm-Message-State: AO0yUKXgtEi5qFBNL8qLukDCzAFlzvcK/f30tuDEmGk1/BW7hkvfQHcq
        VAW4bmdDfq0QCCurwjGtmds=
X-Google-Smtp-Source: AK7set/XcNVsI76A4Go8QQOkFfxynJhAr8f4qvpk02748GD8AZmYKsiFMUliAb6irxidtJ12NYYkqA==
X-Received: by 2002:a5d:67cd:0:b0:2bf:b0e6:f463 with SMTP id n13-20020a5d67cd000000b002bfb0e6f463mr2574616wrw.13.1675276124520;
        Wed, 01 Feb 2023 10:28:44 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r7-20020a5d52c7000000b002bdf5832843sm17845827wrv.66.2023.02.01.10.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:28:43 -0800 (PST)
Message-ID: <cc8561139d020136d0bfa01684317ef25996d184.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Edward Cree <ecree.xilinx@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
Date:   Wed, 01 Feb 2023 20:28:42 +0200
In-Reply-To: <c26d4287-6603-d44f-58fc-ed4c698ea5b3@gmail.com>
References: <20230131181118.733845-1-eddyz87@gmail.com>
         <20230131181118.733845-2-eddyz87@gmail.com>
         <99a2eaa9-aebb-f0c8-1d13-62e1533631e7@gmail.com>
         <48f840c1b879728bda69e059f19c2cea642c1e97.camel@gmail.com>
         <c26d4287-6603-d44f-58fc-ed4c698ea5b3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-02-01 at 16:13 +0000, Edward Cree wrote:
> On 01/02/2023 15:14, Eduard Zingerman wrote:
> > I can update this remark as follows:
> >=20
> > ---- 8< ---------------------------
> >=20
> >   Current    +-------------------------------+
> >   state      | r0 | r1-r5 | r6-r9 | fp-8 ... |
> >              +-------------------------------+
> >                              \
> >                                r6 read mark is propagated via these lin=
ks
> >                                all the way up to checkpoint #1.
> >                                The checkpoint #1 contains a write mark =
for r6
> >                                because of instruction (1), thus read pr=
opagation
> >                                does not reach checkpoint #0 (see sectio=
n below).
> Yep, that's good.
>=20
> > TBH, I'm a bit hesitant to put such note on the diagram because
> > liveness tracking algorithm is not yet discussed. I've updated the
> > next section a bit to reflect this, please see below.
> Yeah I didn't mean put that bit on the diagram.  Just 'somewhere'.
>=20
> > I intentionally avoided description of this mechanics to keep some
> > balance between clarity and level of details. Added a note that there
> > is some additional logic.
> Makes sense.
>=20
> > All in all here is updated start of the section:
> >=20
> > ---- 8< ---------------------------
> >=20
> > The principle of the algorithm is that read marks propagate back along =
the state
> > parentage chain until they hit a write mark, which 'screens off' earlie=
r states
> > from the read. The information about reads is propagated by function
> > ``mark_reg_read()`` which could be summarized as follows::
> Hmm, I think you want to still also have the bit about "For each
>  processed instruction..."; otherwise the reader seeing "The
>  principle of the algorithm" will wonder "*what* algorithm?"
> Don't have an immediate suggestion of how to wordsmith the two
>  together though, sorry.

How about the following?

---- 8< ---------------------------

For each processed instruction, the verifier tracks read and written
registers and stack slots. The main idea of the algorithm is that read
marks propagate back along the state parentage chain until they hit a
write mark, which 'screens off' earlier states from the read. The
information about reads is propagated by function ``mark_reg_read()``
which could be summarized as follows::

---- >8 ---------------------------

>=20
> > Notes:
> > * The read marks are applied to the **parent** state while write marks =
are
> >   applied to the **current** state. The write mark on a register or sta=
ck slot
> >   means that it is updated by some instruction verified within current =
state.
> "Within current state" is blurry and doesn't emphasise the key
>  point imho.  How about:
> The write mark on a register or stack slot means that it is
>  updated by some instruction in the straight-line code (/basic
>  block?) leading from the parent state to the current state.

Sounds good, thank you.

>=20
> > * Details about REG_LIVE_READ32 are omitted.
> > * Function ``propagate_liveness()`` (see section :ref:`Read marks propa=
gation
> >   for cache hits`) might override the first parent link, please refer t=
o the
> >   comments in the source code for further details.
> "comments on that function's source code" perhaps, so they know
>  where to find it.  If they have to look all the way through
>  verifier.c's 15,000 lines for a relevant comment it could take
>  them quite a while ;)

Sounds good.
>=20
> > Thanks a lot for commenting!
> > wdyt about my updates?
> I think we're getting pretty close and I look forward to giving
>  you a Reviewed-by on v4 :)
> (But make sure to Cc me as I'm not subscribed to bpf@vger.)

Sure, will do.


