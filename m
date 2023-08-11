Return-Path: <bpf+bounces-7609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F22779994
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF701C20AED
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16239329CA;
	Fri, 11 Aug 2023 21:36:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4F2AB4C
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 21:36:17 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC62684
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:36:16 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bfafe8a425so2125196fac.3
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691789776; x=1692394576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uaeJPAJtLy1XMf75TvRdhkMP9JhgosSKePodLPRR4H8=;
        b=Y7WdsMqUtTwck7zkjNQWsz+Ye1+199N2yQxFUIoFVuOeRdK42XEMtGQggh5wRr/X0r
         AovtMmOZMLXcIxMhdiE3nxSa13m1P41Q3A65//bqfIDEYdz+qACytLnjM28kYIGOgEbH
         wfGHDAi5+I7+T7PSpO3rjGqnzB2D4kKwxxepbdqUuZgT0KqC2T8OktQT8H6Md1lV4pGS
         5IR/xhZyOQtgPcHm20hHqUXX/zI2sqvVkBnAHHwLJPzZ2HNoOTs3EwpF8jZ5F6Cugc4c
         6nwN60MPSu+JGnxcRnpCOZTnPJqW921AogwFF/sC7YSP95lzHloJgHli8YDt+1H4snj1
         vIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789776; x=1692394576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaeJPAJtLy1XMf75TvRdhkMP9JhgosSKePodLPRR4H8=;
        b=V9bKQErHUAm1InE53Hw8xnO83o32iOkl1ePzuaY/0t3oQLKINInCPqKEt2j4Tmtw3F
         9XjmDu2P1zvmV07x0MXtstbeMzvPixm0M+zDAm7upfIYlgojhHQtr/obeZqxWg4Mm/h5
         ik1SD2+SV/jr++PvqULrMPQsdjy6A8PBXewl/x0cwl0E0IYDy+eTQMrkIs6bp9Ae9Otc
         d9Ni9Cc4OPsIJ8BAETMGRD/mXVvwa7+cxkpcIfHa1a8V2WlloPlF68+RwZg9w1Vf6AIP
         7WlDmZw+SKRSOyTByN8R3IJ8i3Ah1Wm97pQHZqK5NVB1iKD/IqgUfTvqPl+Y8pPj9LY0
         aYcw==
X-Gm-Message-State: AOJu0YyNOu+Zo79aHTbjw8S0sHo/tXBihG0EYhmOvxRFMsXiCMPNkJmm
	33CqhYSGhuVMwNCU0VyBIVCNK0JG1TbYJJYpt7A=
X-Google-Smtp-Source: AGHT+IHUQapEPHad8cJvXF5bIx6PZfEDm0PsMfLl1NJKT2I3LJ37W2IZ2BtXF2T0vmcODrQk/aa0/MzetOZjlufZ6T0=
X-Received: by 2002:a05:6870:8901:b0:1be:dfdf:cb1 with SMTP id
 i1-20020a056870890100b001bedfdf0cb1mr3662648oao.46.1691789776100; Fri, 11 Aug
 2023 14:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com> <20230811172116.GC542801@maniforge>
In-Reply-To: <20230811172116.GC542801@maniforge>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Fri, 11 Aug 2023 14:36:04 -0700
Message-ID: <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: void@manifault.com
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	Christoph Hellwig <hch@infradead.org>, "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear David,

Thank you very much for your lengthy and kind email. I agree that we
should punt on contentious points and aim to standardize what has
already been implemented across a wide range of implementations. Most
of my issues are with the format and presentation of the text, and I
think the content changes it would take are pretty noncontenous. I
don't really have any insight into what the content should be, and I'm
sure that for those who live and breath BPF every day, much of what I
am confused about is indeed obvious.

Concretely I think the following would help improve the
understandability of the document:
* After the register paragraph, describe the memory. As I understand
it it is a 64 bit, byte addressed, flat space, and maps are just
special regions in it. Maybe I'm wrong. There's some stuff about types
in the big space of instructions that maybe makes me think I am wrong.
* Say this is a 2's complement architecture
* I finally understand why the code fields have their low nybble zero.
We should maybe say this.
* Explicitly call out after 5.2 that there is no memory model yet
* Pull up section 5.3.1 to the top, or figure out some way to punt it
to an extension. Maybe introduce maps up top then explain how they are
indexed here.

For extensions if I think I understand the conversation at IETF 117,
it's easy to add more calls to the host system as functions. It's a
lot more of a difficulty to add more instructions, but in the wide
encoding space there is room. We could definitely say that. The memory
model should only modify the behavior of environments with races, so
if things aren't racy, nothing changes. That should work, but maybe I
don't understand what other extensions that people would want to add.
Verification might be an extension, but probably not in the sense we
need to worry about it here?

I hope the above is helpful: as always my ignorance can completely
negate the value of the concrete suggestion, but I do hope it
highlights areas that could use some TLC.

Sincerely,
Watson Ladd

--
Astra mortemque praestare gradatim

