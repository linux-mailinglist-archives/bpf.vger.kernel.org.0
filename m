Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2E6A5161
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 03:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjB1CoT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 21:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1CoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 21:44:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5788315CA7
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:44:17 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s26so33988711edw.11
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysmomrUYsA612qaQDfBAupJH0lKwfMWnBBIZ0w0hy6c=;
        b=bts556BqjUkVEDpqSzs6e2vqta4ncV2/OxzpbIfvWW1GeUmFORip4dTOVB48nNsUsv
         etsaXFunPUzqg7gzuZJRWyMRmd5M6/NXYo1lA73QjlEEhBq9wiRG1ldtLD6xAXs+OOzT
         2EkXGVwY20Wefp8VRU0dl/8on042Q85w+iZM9/qmZ0I768qZuwNE/1Sr4H14IETXo75o
         QjwvxCxfKslUrGbJXU67COxg6LcxnGYLa4qJJTYuoO3yoQxz24/lfWAttPce3htlqwCh
         oDk+6rd6neni5n7Niidk6Bkwnp2GS4tQl7KeicAuVOmQn5aP/bodX4372pXuHUDWZS+I
         1FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysmomrUYsA612qaQDfBAupJH0lKwfMWnBBIZ0w0hy6c=;
        b=n6w0yqmVel2dpIc7obqY4PYbYNQF110Sg/hSc1ydp28aYXhSW3DMRmc8ZgOC/cx/UO
         q/AUkf4945l0GKP1uILCUbe5Ik8LIOGCMWGOjdKbFJAjKflOw/o3T/Wq9F5cY6ddgKpr
         ooPEd8iq8TO9Ue7+lRbuVhMlfP0bTsr+9GVfFg43IUNGeqMBlvXbYc5Fg7EKQB5jsOrV
         GN2yEFVAXvqsrR23WhiXaM/ioGD8VrHvFOJ3BH/nMNb5kEKKHT4kc5ATDQzR0INzzdG7
         VNCBjnajvwZdxbDXtbe8Oap+cxJtaWcMIXQwqlnOJ5REOaFUPSuJqDTl4PCqH4AgKK5w
         JhcQ==
X-Gm-Message-State: AO0yUKXwpTZsV5doDqKW0iZ+ctL9shVBAMqTeaC/m3HQe/F8+EmEro+j
        W2q/uTJrJ+wPOhrf/MxIRu59joDTjrvyjC0kQJs=
X-Google-Smtp-Source: AK7set9ZMUhBuEF5dMla8Cn3AIuLyL8guk313WZ8ZMR65p1DCBTsGGT0pG075IftAdqAC5WzAjcTfckGtVtd7MwAxug=
X-Received: by 2002:a50:c007:0:b0:4ab:4933:225b with SMTP id
 r7-20020a50c007000000b004ab4933225bmr880121edb.6.1677552255663; Mon, 27 Feb
 2023 18:44:15 -0800 (PST)
MIME-Version: 1.0
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
 <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com> <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
 <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com> <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
 <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
 <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com>
 <199e5475333f49eeebfee6e34571638e4dd9d737.camel@gmail.com>
 <CAEf4BzbGA=wSeoPpg+mKp-nh7qRPb6Bp+DfWgvSaWtPaWC7+nA@mail.gmail.com> <a6e526ec1408ec4c833b19f8d482ace57dc30c11.camel@gmail.com>
In-Reply-To: <a6e526ec1408ec4c833b19f8d482ace57dc30c11.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Feb 2023 18:44:04 -0800
Message-ID: <CAADnVQLrvEzabkJjerAwdOgbnA=ERYinYqboN2--jqaeDm4Ygg@mail.gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Faust <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 4:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> I still think that presence of a literal string "bty_type_tag" might
> make some grepping easier but whatever. If there are no further
> objections I'll post the changes using "btf:type_tag" literal tomorrow.
> Andrii, thanks for the input.

I don't think there is precedent for using ':' inside DW_AT_name.
Can we actually use the same "btf_type_tag" name?
Aren't we gonna use a different container than DW_TAG_LLVM_annotation ?

Since we're picking a standard across gcc and llvm it will be
some common DW_TAG_... with the same number, no ?
I forgot what we agreed on during office hours.
