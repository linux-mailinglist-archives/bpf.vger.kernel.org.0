Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B65644BEF
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 19:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiLFSki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 13:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLFSkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 13:40:37 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B09303C2
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 10:40:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 82so14202848pgc.0
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn26Cqp71iciQeKdo406U5eLuwch4ssiJK8YOVshbHw=;
        b=QHZma8W9DuP452wGg/TA+iBtp8afEOwCdSFZjDRjZQMzFyp2NiLIRz3X0lv9GfNTJP
         fXoVez5Mv5ESWbFIvpIICdOyLD6/vAGJ43HYffFp/EqkHatx5ZodVlLM3ulqt9elh2Sm
         sg8NHllSzDeyO4dbKt4Ke6DnNid0rFYo1PTouvJv5Mi+4/DwYBStvf0IxxJxfSEj6tRF
         dxegjSG3rH8hGw3HtdO/SRk8ADAyqVFGiRtcdZrRNpKBrLjTGQQclfYGUMED0eH/6xGt
         SGOyjVN3ZD8yqE0Rta6IIVb7EQYQs05pSCL6+0KHN/mHL2ClDrb8GKSvH2Ghf3UN2+7Z
         vSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn26Cqp71iciQeKdo406U5eLuwch4ssiJK8YOVshbHw=;
        b=C8RKGGt1dp6vqqP4pboA1mtX1p4uXbGj4b/NS7HfoeYMREIwK7UqAdaDZ4zF9iCiSx
         8YEeE80saBDPUA3SK5hJuuS/Fz4N/+OQrZNE5EDym1cQ4TIAZWGhkD5p6yhU9zpGyRda
         /dKscN67aXm12F7cVXZIcFQRWgXp2wSBMG4E/ndc7NT9S+5hziTk3o8dEqMT4rTuwyvd
         lYwRXzDJZ7lstggRTMDVHn9TuXrHrsm3dhsSmqYhCr5WHzDdn2f4ZW3++1sCEPqmUdNA
         1egtY+0AXye7hFuWKuQ8ZuuergObRPfogoQ9t+fD2OYQj92h+n7W8F+yVatJ3o0x1Rk3
         mFJw==
X-Gm-Message-State: ANoB5pn0xNOb8dn0blZz1uM6DVeNuhzfVfvZrwrgOhwihRLx5UAOwJZh
        y5kNIFm7F/dzuVM3YyHHrp4VVKQHF3k4Xlr0dNgBXQ==
X-Google-Smtp-Source: AA0mqf5N/F+0Hk1nwKYvAwD3jvEZ3LXJtEa3LPoLQ6RPZZclJsEdlRbOvq5/YfwBnvfFwJuD5FkekUErXbE8bcNIZBk=
X-Received: by 2002:a63:1747:0:b0:478:1391:fd14 with SMTP id
 7-20020a631747000000b004781391fd14mr40180113pgx.112.1670352036197; Tue, 06
 Dec 2022 10:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20221206011052.3099563-1-sdf@google.com> <87o7sgu4zr.fsf@toke.dk>
In-Reply-To: <87o7sgu4zr.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 6 Dec 2022 10:40:24 -0800
Message-ID: <CAKH8qBsz-pP82vLt2g0JzL3+ErnTN8wDxYNwyFHby3nRiXtzWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Bring test_offload.py back to life
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 6, 2022 at 3:49 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kerne=
l.org> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > Commit ccc3f56918f6 ("selftests/bpf: convert remaining legacy map
> > definitions") converted sample_map_ret0.c to modern BTF map format.
> > However, it doesn't looks like iproute2 part that attaches XDP
> > supports this format.
>
> It does if it's linked against libbpf; what distro are you on that
> doesn't do that?

Ah, I've been using my own statically compiled version that doesn't
use libbpf; recompiling with -libbpf_force fixes this part.
I'll resend with only base_map_names changes (+ skipping builtin), thanks!
