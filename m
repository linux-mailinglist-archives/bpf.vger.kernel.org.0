Return-Path: <bpf+bounces-81-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A354A6F7BC0
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDEA280F67
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8161C05;
	Fri,  5 May 2023 04:08:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DF1854
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 04:08:58 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09E8A7D
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:08:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-956eacbe651so249442066b.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 21:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683259735; x=1685851735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJlO1YsjswNSA3Wb4+9Y8V+mOHk2FP3ADI7n/gJXGis=;
        b=GN4hRsSub+hR7sX35fuviRrINGZ/9fcUPHJ8oy3Qx0bood2p2SwtLmg8TncZH9CK1n
         iqow6/F7yHwYUokzoTyCrxok95f9YY4+uq63DLdHqnoehDzPOkop/pWqaDrL+SeT5l/B
         +rncRW8RozkqzGIln9xpQ8t3pY30O0GyzIs6jOZhmjapgsv7Cy1XCCXNJHY14aYu7ozu
         G7JXulnQiSVX2j5pmczvGVdXI8RX8kbeR9OEkYpBYCyLZ1Cj+x5bf21iYoLjxFcXBmDi
         awUlbOfhFlKXkqGYO5gMbS3All7+kdgUqHh4hfSsmW+w2vdzVGmhm64s7unQM+rEZwn3
         1cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683259735; x=1685851735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJlO1YsjswNSA3Wb4+9Y8V+mOHk2FP3ADI7n/gJXGis=;
        b=TNenbbiUiDyXbdxBvu5iIBAXJo6FwfRLVBh1IQW4mNsvNCuAZR4PuX9WiKmFnjjeRU
         CQVSNesBYR2cAoIVOddhOvPJLSsZ+lFu7YKtuXmvOSQw4LTF7bOSFlNrzUrGbidm5j1B
         LcrMgTdSgtPOIFfW5PHn+DXku9FYuqw6NSz5xqNL1HXeMz8IiKCo63AMXJRh58GrO6UK
         mO0E8jFnUKnQVC3HK7lE13ODg5Aw4Jhad+0nDbGeCIUTdY3v5ijDEFokcHAHvtse0Bik
         3cspVX11WTbgOkn7Q73JKzw5MxsJkNPmwq109ilbB4n/v1awJB8TlIsDhYkeYO34m3KB
         6Z4Q==
X-Gm-Message-State: AC+VfDyicddZiM9aHcWdD28IGF3f4zKIleAP7Krg0Wixtvmeigzr0LWU
	llWZFriOZUiUX3EAESAvMfvvBmI87YFfquU2k/KleVmC
X-Google-Smtp-Source: ACHHUZ7d8zEwjPpli9/IKRGFOS+qh/U2qpONpdk7K175drRRup/QAugmTFDCpl89RvwjzNFN2Lo3EjcCW21oCrXDgW4=
X-Received: by 2002:a17:906:9b94:b0:960:ddba:e5c7 with SMTP id
 dd20-20020a1709069b9400b00960ddbae5c7mr915990ejc.40.1683259735048; Thu, 04
 May 2023 21:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230505000908.1265044-1-andrii@kernel.org> <20230505000908.1265044-4-andrii@kernel.org>
 <20230505015423.3ph2xqrlftwcfgoe@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230505015423.3ph2xqrlftwcfgoe@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 21:08:43 -0700
Message-ID: <CAEf4BzZLXeB9APpvnrU7tosSRBqQzK-U4jKBuQVxPdsCF4v3uw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: encapsulate precision backtracking bookkeeping
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 6:54=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 04, 2023 at 05:09:01PM -0700, Andrii Nakryiko wrote:
> > +struct backtrack_state {
> > +     struct bpf_verifier_env *env;
> > +     u32 frame;
> > +     u32 bitcnt;
> > +     u32 reg_masks[MAX_CALL_FRAMES];
> > +     u64 stack_masks[MAX_CALL_FRAMES];
> > +};
> > +
>
> > +static inline u32 bt_empty(struct backtrack_state *bt)
> > +{
> > +     u64 mask =3D 0;
> > +     int i;
> > +
> > +     for (i =3D 0; i < MAX_CALL_FRAMES; i++)
> > +             mask |=3D bt->reg_masks[i] | bt->stack_masks[i];
> > +
> > +     return mask =3D=3D 0;
> > +}
> > +
> ...
> > +static inline void bt_set_frame_reg(struct backtrack_state *bt, u32 fr=
ame, u32 reg)
> > +{
> > +     if (bt->reg_masks[frame] & (1 << reg))
> > +             return;
> > +
> > +     bt->reg_masks[frame] |=3D 1 << reg;
> > +     bt->bitcnt++;
> > +}
>
> So you went with bitcnt and bt_empty ?
> I'm confused. I thought we discussed it's one or another.
> I have slight preference towards bt_empty() as above. fwiw.

sigh, forgot to drop bitcnt and ifs... will remove ifs and bitcnt in v3

