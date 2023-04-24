Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28AF6ED319
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjDXRGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 13:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjDXRGX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 13:06:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C877F4EF1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 10:06:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b35789313so3480671b3a.3
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682355981; x=1684947981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKfBhNNw308gtB2lESvceR4vYEIxkvyzyqs/mrXUcRU=;
        b=4njW65LlSj5ciMIKa4UHE0BKt8C1a7VGhLewBjEtWwIiyLe8S2HaxQol3RUo09EaZx
         I4Zu4wmaoZ6qy5sqZwKJUbRkSFq2UQikYnO/kJQmEJOxEqQc+kpUw8y1BPqU5+JIPRqU
         gLep25oy1EXEtvgZ80s+ofkuZYpxEN70oeq58Ao5qWOGoWrrvvBCyn3m2oXY4njPvdPd
         2ewPYVSm5dSvwC1LlIkMVYYJ/B0A8nFC4tVwOaSHrJXwhY9mSw7ss8fpv2FraTt60dp9
         L2CrO/t/kgbOS6xGHgubTLEAa39+UgcNiq271PpP+Q0qI/HRaQ+VacOqEFMlBLxbgr+e
         nzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355981; x=1684947981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKfBhNNw308gtB2lESvceR4vYEIxkvyzyqs/mrXUcRU=;
        b=GqwAnw4E03xXvp9TftOgxcbPO9avTXp0HtCptvRAdRpvgecaqMgSbuBsPWGPnYor65
         PgoAs0EUlp7Q2XGd3aoDg905y2XLWL/n3H1RAYXYsiMG6G0cRgPpiEypkWwTvtPhyvbp
         h5Gf4dAxIXCg8bEwk0w2hEzftWZmqGSEcpUqWOWfdlvwqjfnouV7DChZlnH3jqBJ3Wzj
         PP2rEy5Xm7p9xpGFQfoJ1zzixG8Kbfleytj8hHMQIspD+R148td1t7TdvYpYnA+n0HT4
         N/qAmf8L8zJfz6V1LDuK3rT5dRuUJzvk52xZnKlJ9CRagZULY3m+TwH780WVQLwKMCP/
         M4ew==
X-Gm-Message-State: AAQBX9cSqYxtbAOU25hyoN9qUjix44Zxd5zQdiA1UIj121T6lBzCtqvL
        I7lGTshOT7yflaAu6mz1h4X2Vkzk/TDacNJU6+IvUA==
X-Google-Smtp-Source: AKy350ZfK2lzATSAPf+j1daAndGY0yjzSxagdrhcY1uM4Jm54r86jlym7L1qDnO9M4lvYs2hfB4btsRe6LC2TdARO/U=
X-Received: by 2002:a17:903:22c8:b0:1a6:c12d:9036 with SMTP id
 y8-20020a17090322c800b001a6c12d9036mr19554297plg.33.1682355981062; Mon, 24
 Apr 2023 10:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230420145041.508434-1-gilad9366@gmail.com> <ZEFrcoG+QS/PRbew@google.com>
 <2ebf97ba-1bd2-3286-7feb-d2e7f4c95383@gmail.com>
In-Reply-To: <2ebf97ba-1bd2-3286-7feb-d2e7f4c95383@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 24 Apr 2023 10:06:09 -0700
Message-ID: <CAKH8qBuntApFvGYEs_fU_OAsQeP_Uf2sdrEMAtB4rS6c6fhF9A@mail.gmail.com>
Subject: Re: [PATCH bpf,v2 0/4] Socket lookup BPF API from tc/xdp ingress does
 not respect VRF bindings.
To:     Gilad Sever <gilad9366@gmail.com>
Cc:     dsahern@kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
        john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
        shuah@kernel.org, hawk@kernel.org, joe@wand.net.nz,
        eyal.birger@gmail.com, shmulik.ladkani@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 23, 2023 at 4:41=E2=80=AFAM Gilad Sever <gilad9366@gmail.com> w=
rote:
>
>
> On 20/04/2023 19:42, Stanislav Fomichev wrote:
> > On 04/20, Gilad Sever wrote:
> >> When calling socket lookup from L2 (tc, xdp), VRF boundaries aren't
> >> respected. This patchset fixes this by regarding the incoming device's
> >> VRF attachment when performing the socket lookups from tc/xdp.
> >>
> >> The first two patches are coding changes which facilitate this fix by
> >> factoring out the tc helper's logic which was shared with cg/sk_skb
> >> (which operate correctly).
> > Why is not relevant for cgroup/egress? Is it already running with
> > the correct device?
> Yes.
> >
> > Also, do we really need all this refactoring and separate paths?
> > Can we just add that bpf_l2_sdif part to the existing code?
> > It will trigger for tc, but I'm assuming it will be a no-op for cgroup
> > path?
> The reason we preferred the refactoring is to avoid triggering `inet_sdif=
()`
> from tc/xdp. This is because in our understanding, the IPCB is undefined
> before
> IP processing so it seems incorrect to use `inet_sdif()` from tc/xdp.
>
> We did come up with a different option which could spare most of the
> refactoring
> and still partially separate the two paths:
>
> Pass sdif to __bpf_skc_lookup() but instead of using different functions
> for tc, calculate sdif by calling `dev_sdif()` in bpf_skc_lookup() only w=
hen
> netif_is_l3_master() is false. In other words:

[..]

> - xdp callers would check the device's l3 enslaved state using the new
> `dev_sdif()`
> - sock_addr callers would use inet{,6}_sdif() as they did before
> - cg/tc share the same code path, so when netif_is_l3_master() is true
>    use inet{,6}_sdif() and when it is false use dev_sdif(). this relies
> on the following
>    assumptions:
>    - tc programs don't run on l3 master devices
>    - cgroup callers never see l3 enslaved devices
>    - inet{,6}_sdif() isn't relevant for non l3 master devices

Yeah, that's what I was assuming we should be able to do..
But we probably need somebody who understands this part better than me
to say whether the above are safe..

If nobody comments, ignore me and do a v2 with your original approach.
