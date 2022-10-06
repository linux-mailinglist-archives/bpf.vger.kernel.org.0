Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34D5F5D81
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 02:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJFAF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 20:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJFAE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 20:04:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D587F8F
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 17:03:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a13so688086edj.0
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UueMNShpjalnt1MJMoHUvCEN8UobeKxOHze1vmkIPjQ=;
        b=Q6BzsauLGSE/5NhXdVHU6y1O4JRtl9NfwEoXcbyO6k8+oDpmzR8UHRrayYbQk8SMIU
         +Ll95wXTEM6lHKTKz/48ALBcmh2Soe5dmkRoMcxQFhkJtlN1hBsVc+SieSwRXGkVRWp1
         D7FECpyIaqmnGQRiJf+HUsX84LWYdPHWnvaC71s3vJypRjK2L56YVNK8GLUo8q7Wc/PX
         Cz7s47tTfqnS5h+A1nilpJuDw0sE9dEpMIanri5mL8plh+ibaXq8c01dbGMPHK0FfOPf
         0ytTQOpUcKRDwT1NsXk0LZ+ojJU6CpJh11J78UAjvHzaKLh/8YXy9cw+hKT+au3Wgoc6
         C9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UueMNShpjalnt1MJMoHUvCEN8UobeKxOHze1vmkIPjQ=;
        b=jSzcRU2jtzMBxf00Uu71vDuvhzQUvm4vccRlFzDS7or5zjTTv7p2V5wR5iJR2Hc7LY
         PljrOEQtQLwTYSgnx4qxIXri0UXi0M3L2vCQ0nJ+EPrZFJ7H9/RRJQPhzM4z5pQBzReQ
         UfNXJwKytjHSYjcOdY/V9ZvwPPQdVJv1m69tb1r5empdJXW1sKCgy/td7OQ4ebKjW5M7
         IufxL56BDi9TS98cWuGCYkYflUb3vViz3qEvEXi6JtpjafEEPVKSii1VfIvg+PeQ7NRt
         jAEGESOWYQ7mTPdW+GcbUOJXIQ4IfSPq/9jNJcCcOIG4uIqZuM1IzAPbgQOFHhEcgJ4L
         sqaA==
X-Gm-Message-State: ACrzQf28UA6RNvaoWnDZGNzDUPrWxGO1FX3WVicsQABYc0HDVjX2ACpW
        GGaKd0X5QAPrQVKfRZXMNOH8rpv8uDiEEU4FGj0=
X-Google-Smtp-Source: AMsMyM50huRuncpgj3PhhU4d5Oh1s7lTxWezuDh/ZQkeOzaMw2ScrgieSmOgXdackq7ESO2tUj+VQ230UBBIQQvAqi0=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr2046489edb.333.1665014629877; Wed, 05
 Oct 2022 17:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221005161450.1064469-1-andrii@kernel.org> <20221005161450.1064469-3-andrii@kernel.org>
In-Reply-To: <20221005161450.1064469-3-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Oct 2022 17:03:38 -0700
Message-ID: <CAADnVQLm_8otwwcTEv=8-fE_220i_o0AhokNwxkSnUg7z8a1rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add BPF object fixup step to veristat
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 5, 2022 at 9:15 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add a step to attempt to "fix up" BPF object file to make it possible to
> successfully load it. E.g., set non-zero size for BPF maps that expect
> max_entries set, but BPF object file itself doesn't have declarative
> max_entries values specified.
>
> Another issue was with automatic map pinning. Pinning has no effect on
> BPF verification process itself but can interfere when validating
> multiple related programs and object files, so veristat disabled all the
> pinning explicitly.
>
> In the future more such fix up heuristics could be added to accommodate
> common patterns encountered in practice.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/veristat.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index 38f678122a7d..973cbf6af323 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -509,6 +509,28 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
>         return 0;
>  }
>
> +static void fixup_obj(struct bpf_object *obj)
> +{
> +       struct bpf_map *map;
> +
> +       bpf_object__for_each_map(map, obj) {
> +               /* disable pinning */
> +               bpf_map__set_pin_path(map, NULL);
> +
> +               /* fix up map size, if necessary */
> +               switch (bpf_map__type(map)) {
> +               case BPF_MAP_TYPE_SK_STORAGE:
> +               case BPF_MAP_TYPE_TASK_STORAGE:
> +               case BPF_MAP_TYPE_INODE_STORAGE:
> +               case BPF_MAP_TYPE_CGROUP_STORAGE:
> +                       break;
> +               default:
> +                       if (bpf_map__max_entries(map) == 0)
> +                               bpf_map__set_max_entries(map, 1);

Should we drop if (==0) check and set max_entries=1 unconditionally
to save memory and reduce map creation time ?
since max_entries doesn't affect verifiability.

Applied the set for now.
