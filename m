Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240416D2203
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjCaOF1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 10:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCaOF0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 10:05:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9FE12845;
        Fri, 31 Mar 2023 07:05:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w133so16730475oib.1;
        Fri, 31 Mar 2023 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680271523;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TG7hOVKj8hjwtdVglGgBq4H/JPEbYS7Fg4dAzfyPA9s=;
        b=ahCSs52cZMbJL0ZLmqvqQEMoNdRWjst0ZEk+BQe0g/nRh1MI0oovU/TCnr1/PjOWxf
         3r+OU4UW3JrVCjSs9pfQ909MwNdlgY4Totkuq0r1KZSfIzYeG5E+T+WAI7b9mJYWuJdF
         yn9TnX/qYXlcATkP+VIuEAG2jHRPYZJBI8GXkKRreF+EAw4qOwZqS2AbUY1hUe5vgaa/
         sdw78okZWJW2mEhl63ia39NJWB9yFRXeBFiHfQMtyKpiyjOFNceJZkUtBsti4Yi/Uo9K
         QvM8zILdMjQc4+wEmZD9l6WLis/ZHnYSxBEd+GksKnDiZCPGXDsM0oyQ3AJIf7GS+VMy
         MkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680271523;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TG7hOVKj8hjwtdVglGgBq4H/JPEbYS7Fg4dAzfyPA9s=;
        b=E7Vjg0D33owBfx42+/PwQZR2knblN2Rd0V10z8O4+22/KXOAqKSnDZDgcBMCLacvaI
         n4h7zxH3TEF2AKz487cC8ldcBsoL++SfQUBYZ1wQ0dJoc6JtbK8urgS2+SFtR8DObJYx
         wv7gC4wccnGBK5Z7LmS6icKiJ9B+GunrvwWxBVO8/sZqk55BeZ9/EbAN5Ab46qQ9g7Hw
         T8rhazsbP+rj+s0zO8B/BvGGUD1W5ocrk+K4EiEHQm5YXLW/o1HuubdHqzW6VYYCqaKW
         hjMv+VXGU/+llh9FK45vZuLctlASiIuySeXEUvlJHRDpdwggPTviovqZQH7Fe8LkHaLs
         WTBA==
X-Gm-Message-State: AO0yUKW98U7VscBTzSc7zZrLb3QxRbSwqVTo8fcsHVdEz6/qUbFSrcqY
        vv7osl4MKv1MVejaDjyQC8M=
X-Google-Smtp-Source: AK7set/qXuYEd2UFsfHCJXzn9Pyu6MGrnstvwJ9JMyqkOBiAFfGSBEam6fxZ/2/ALrZ68frd4/WMcQ==
X-Received: by 2002:a05:6808:6d4:b0:384:d79:d426 with SMTP id m20-20020a05680806d400b003840d79d426mr12277320oih.13.1680271522877;
        Fri, 31 Mar 2023 07:05:22 -0700 (PDT)
Received: from [127.0.0.1] (189-94-30-61.3g.claro.net.br. [189.94.30.61])
        by smtp.gmail.com with ESMTPSA id e2-20020acab502000000b0038998fa6c2bsm574156oif.33.2023.03.31.07.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:05:20 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:05:13 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
CC:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_dwarves=5D_fprintf=3A_Fix_=60*=60_not_b?= =?US-ASCII?Q?eing_printed_for_pointers_with_btf=5Ftype=5Ftag?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f044179e39ec9e7665232eb5abad959ef5e19119.camel@gmail.com>
References: <20230330212700.697124-1-eddyz87@gmail.com> <ZCbOdWCKKzLlprIs@kernel.org> <f044179e39ec9e7665232eb5abad959ef5e19119.camel@gmail.com>
Message-ID: <98E797CF-3C40-48F7-895F-46DF9D57E3BC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On March 31, 2023 10:35:52 AM GMT-03:00, Eduard Zingerman <eddyz87@gmail=
=2Ecom> wrote:
>On Fri, 2023-03-31 at 09:13 -0300, Arnaldo Carvalho de Melo wrote:
>> [=2E=2E=2E]
>> > =20
>> > +static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_=
t id)
>> > +{
>> > +	struct tag *type;
>> > +
>> > +	for (;;) {
>> > +		if (id =3D=3D 0)
>> > +			break;
>> > +		type =3D cu__type(cu, id);
>> > +		if (type =3D=3D NULL || type->tag !=3D DW_TAG_LLVM_annotation || t=
ype->type =3D=3D id)
>> > +			break;
>> > +		id =3D type->type;
>> > +	}
>> > +
>> > +	return id;
>> > +}
>>=20
>> This part I didn't understand, do you see any possibility of a
>> DW_TAG_LLVM_annotation pointing to another DW_TAG_LLVM_annotation?
>
>Not at the moment, but it is no illegal, it is possible to write
>something like this:
>
>    #define __t1 __attribute__((btf_type_tag("t1")))
>    #define __t2 __attribute__((btf_type_tag("t2")))
>   =20
>    int __t1 __t2 *g;
>   =20
>And to get BTF like ptr --> __t2 --> __t1 --> int=2E

Right, thanks for clarifying, I'll add this as a comment above the skip ll=
vm function=2E

This patch is already in the 'next' branch, will move to 'master' later to=
day=2E

- Arnaldo
>
>> [=2E=2E=2E]
