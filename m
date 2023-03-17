Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C406BEE93
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCQQkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 12:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCQQkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D616ACA
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:40:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so22688680ede.8
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1679071213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QabBjqe2XbjevEm14KRIDTHO72xm58hVPOM5aKdY1EM=;
        b=SmuFrqliI4pXWokbsYJ1JbQuG8D3kZGXzs24vZv9KCLKXFFmmYC0Ns4r1mIknE+jEM
         0DdfHUkKviXMJrBb6L9oDb+ppu2GsLN0jhA0KvQwZ05E9QB3q1bli1zt8O8fT6MZ1cFh
         o7N7APYQ8ALlK00WHktrfPzTlZCeeVMBLE5SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QabBjqe2XbjevEm14KRIDTHO72xm58hVPOM5aKdY1EM=;
        b=ELqEXZDXuM5tAGX1BtNc4nEMIz+B3WDZ86PKfDOmiDQDhGiqdDcoo9qYp5LZm0Bl7T
         AFjg4DayGDUeGRcLt3aF6STVdVPp3X7Rf6gONuYWZpk0+5dZRhrK4/9gb3XTGBvD5Rqr
         Q9bzkSnTYbhDd1VIVWzLas4/3qRvxO6LhffS9slDcpylnwwv7nSU3hjjOsGG0Oozl5ly
         QINl+QOPO4fGFmkbyXpYgIILiyESsGcKeyavs3+0ZjuinPQpQNM2jb6hSjt9YezRaGxB
         Ni3Z5kxGAdUcU7TXJhJssHSm//xtera3k3St9h7OnJ9JbJPmbBEqZ/NpGjXWjhXBrFVn
         wHlQ==
X-Gm-Message-State: AO0yUKV0erAaR/iNvj9MURD4BGseJ+Hl7DCal4NbQIGxcDFwPY/cnemd
        KiZ4YccxBL3R770BuXjECsSMDb40bHLKwit3wZLfM309CI6dRyl0JlM=
X-Google-Smtp-Source: AK7set8MLPtiI0PCFbOe2Y6Dn6p0q7ySD/HPpu5KlZlbm6BxhXCx3eXNddkdTZ1pentiofF2PXnU4G7PzFARFVPOUW8=
X-Received: by 2002:a17:907:1c11:b0:932:6a2:ba19 with SMTP id
 nc17-20020a1709071c1100b0093206a2ba19mr1274446ejc.14.1679071213553; Fri, 17
 Mar 2023 09:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
 <CAADnVQLcqDOzXPSUUNyFE=UJHBP-ZgOEqFfaGynTUL-jQnw-=w@mail.gmail.com>
In-Reply-To: <CAADnVQLcqDOzXPSUUNyFE=UJHBP-ZgOEqFfaGynTUL-jQnw-=w@mail.gmail.com>
From:   Chris Lai <chrlai@riotgames.com>
Date:   Fri, 17 Mar 2023 09:40:02 -0700
Message-ID: <CAAFY1_66-b063v+edsHPBbK6iuiE=KoY38=kr0FVzVLg5gkE_w@mail.gmail.com>
Subject: Re: bpf_timer memory utilization
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Might be a bug using bpf_timer on Hashmap?
With same setups using bpf_timer but with LRU_Hashmap, the memory
usage is way better: see following

with LRU_Hashmap
16M capacity, 1 minute bpf_timer callback/cleanup..  (pre-allocation
~5G),  memory usage peaked ~7G (Flat and does not fluctuate - unlike
Hashmap)
32M capacity, 1 minute bpf_timer callback/cleanup..  (pre-allocation
~8G),  memory usage peaked ~12G (Flat and does not fluctuate - unlike
Hashmap)




On Thu, Mar 16, 2023 at 6:22=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 16, 2023 at 12:18=E2=80=AFPM Chris Lai <chrlai@riotgames.com>=
 wrote:
> >
> > Hello,
> > Using BPF Hashmap with bpf_timer for each entry value and callback to
> > delete the entry after 1 minute.
> > Constantly creating load to insert elements onto the map, we have
> > observed the following:
> > -3M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
> > peaked around 5GB
> > -16M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
> > peaked around 34GB
> > -24M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
> > peaked around 55GB
> > Wondering if this is expected and what is causing the huge increase in
> > memory as we increase the number of elements inserted onto the map.
> > Thank you.
>
> That's not normal. Do you have a small reproducer?
