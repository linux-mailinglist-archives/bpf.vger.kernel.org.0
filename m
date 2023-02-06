Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A522068C9E3
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 23:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBFW7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 17:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjBFW7I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 17:59:08 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EA030B15
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 14:59:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id dr8so38623076ejc.12
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 14:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UpJGdpImCgr3zvEVMKWpg/Br87zgNnw0QxzA3IRYuHQ=;
        b=LtuQbwZ6lEZg/uz9sb42AHt1I8W5C/l71yPT38rVudtWX1YHUZYl1TNOgQbmp1Rdjm
         AJpr9JFHQMTla8E8Dt/a4M42fngg/niB9GJDzcvpCqgmKSGATE6TXf4H4NvEhNuIAZ/7
         oYPkOIGXhmhLehQ9t13B7PwH5guegVgtFozO8bZSb0U8Lo65SGnC10USF6DzE0G7ZDJd
         VFMDsmNzTopYLSiHdglj0CFf9gXGcyf2j2G7jT0w3LNs9oRrF3dQbwbBe/WyXPLdkzR+
         9EHCz/auQ+ilCb0WkP8q7SsxoVxIkd2bRK5DolhifYM8qE1agnr05tFyICQyv0zUKIpC
         txlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpJGdpImCgr3zvEVMKWpg/Br87zgNnw0QxzA3IRYuHQ=;
        b=Z77jr9E+NAlSSYjVqCP+UpfAvotr7vANOwLPkewzz1EUsV3xxW/IjXCI8X4BvkKyLz
         eiINCeAxwCAf2mlcHa17QL6d1Q+/CFNoIigV8nrYAbE4o0IomZCm3bPgnLZAKj1BdZfM
         qZxpAztWpVBB/1J/S6JlLZX3nmJBrTgCzU1404Lg/CfKsLV9+ShnbV9gE29Ecre1M2cV
         tNMr58s8sXj4+AcLbRiUuMCnXFwv+mu4tE+YNnfBfFP9BP43MlGyONdOW7ju8xCk/fdQ
         i0mGpBwwCQBoIY1VcMX48SRyHiRxVs537nJTGv0qkoP9Ju40chMCwR2PBwcwHR5lcVyy
         UWyA==
X-Gm-Message-State: AO0yUKUTeS5/vNFV7UuqannWVn74Hjd6unDKpg0n2b0QbV8tOUP5k/5E
        OClYmLVlMGxyVs39cApCObTZxImtNb+EfmGeXX4=
X-Google-Smtp-Source: AK7set8ly93rG6k/n+5Or3creBbFynY88iy/hVyOjz+gEyYr3QQ1M7tbHW7AUAzhmhbNlHP6a1oCBTssy8//mu+PTdk=
X-Received: by 2002:a17:906:924c:b0:877:5b9b:b426 with SMTP id
 c12-20020a170906924c00b008775b9bb426mr287777ejx.12.1675724339540; Mon, 06 Feb
 2023 14:58:59 -0800 (PST)
MIME-Version: 1.0
References: <4ebd4e68dec83863c51a9114e6507524c8feafb7.1675698070.git.fmaurer@redhat.com>
In-Reply-To: <4ebd4e68dec83863c51a9114e6507524c8feafb7.1675698070.git.fmaurer@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Feb 2023 14:58:47 -0800
Message-ID: <CAEf4BzZ565hQLAhHixb9pDWtS9CD72u5-rswxN-vwj-BPXKQ-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: Use BTF map in sk_assign
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
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

On Mon, Feb 6, 2023 at 8:07 AM Felix Maurer <fmaurer@redhat.com> wrote:
>
> The sk_assign selftest uses tc to load the BPF object file for the test. If
> tc is linked against libbpf 1.0+, this test failed, because the BPF file
> used the legacy maps section. This approach is considered legacy by libbpf
> and tc (see examples/bpf/README in the iproute2 repo).
>
> Therefore, switch to the approach recommended by iproute2 and use a BTF
> defined map. This is also well supported by libbpf.
>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---

This test was updated (see [0]) to support iproute2 version with and
without libbpf support. Please check the latest bpf-next/master.

  [0] 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")

>  .../selftests/bpf/progs/test_sk_assign.c      | 24 +++++--------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
> index 98c6493d9b91..b0536bdc002b 100644
> --- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
> @@ -16,25 +16,13 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
>
> -/* Pin map under /sys/fs/bpf/tc/globals/<map name> */
> -#define PIN_GLOBAL_NS 2
> -
> -/* Must match struct bpf_elf_map layout from iproute2 */
>  struct {
> -       __u32 type;
> -       __u32 size_key;
> -       __u32 size_value;
> -       __u32 max_elem;
> -       __u32 flags;
> -       __u32 id;
> -       __u32 pinning;
> -} server_map SEC("maps") = {
> -       .type = BPF_MAP_TYPE_SOCKMAP,
> -       .size_key = sizeof(int),
> -       .size_value  = sizeof(__u64),
> -       .max_elem = 1,
> -       .pinning = PIN_GLOBAL_NS,
> -};
> +       __uint(type, BPF_MAP_TYPE_SOCKMAP);
> +       __uint(key_size, sizeof(int));
> +       __uint(value_size, sizeof(__u64));
> +       __uint(max_entries, 1);
> +       __uint(pinning, LIBBPF_PIN_BY_NAME);
> +} server_map SEC(".maps");
>
>  char _license[] SEC("license") = "GPL";
>
> --
> 2.39.1
>
