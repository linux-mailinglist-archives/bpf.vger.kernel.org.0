Return-Path: <bpf+bounces-575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62638703EE7
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC1281129
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAC1953E;
	Mon, 15 May 2023 20:54:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB4FBED
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 20:54:03 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C69EC6
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:54:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24deb9c5ffcso8908156a91.1
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684184042; x=1686776042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYex7MoVCjYut7mpFFiXxtl1OP8YBfo23zfW6u/h6wI=;
        b=oIGRVan4bwqk8tk02ZbvclRr+BwAtVAC5u6AysnFODtcNugYcXORR0T0fSo+GB4uBH
         UbXQe9VvU5zj9SIp4hFC+cG6Ev0/qHErjEZZieg9mNzD44wAppxPaUn3YM8S7R8MmADy
         4QmFr3I8QcaiRwdLNNweZppYIMGhBxTk9xbDGVY/0bqaQbfiopwez9EpiLB43WYHroZJ
         17Al4l0NqeVDeWpMghtKWE76WPG7Jz/xdftEBP4kLDZe3A8IRhGtys6nIULZvKmsjRhy
         E3ZHJlcfKAwKiGdvBGFzUK8AbIsHI76JQXuO/r/VQWQLl9Hl8sbhmYyhPufvxo3egFJF
         03uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184042; x=1686776042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYex7MoVCjYut7mpFFiXxtl1OP8YBfo23zfW6u/h6wI=;
        b=KsIk+gRXcCFUGw2mQ9rmIlhWpJIbQhyaETc2BRH2cNJ1lLqpdFESGSOk5UB6geInXT
         u/HaCjAA49zDe6TIVKqoNy+FfMrIRJ3JJMXSYmZDcfyRLXM2fzBC0PfnN5iHMEVozjzD
         wAPEd2EGMVC8RtpR2eby0QqzSIzzAepF9C3hqt/Eexj2o2CNw1RbHJEahC2T9+6Lyh+A
         COK7qFm6l/B9RgiYdeenSR4boj9dYf8WGWelXFhre3OTwiaVIA+WJmRKZxjeG/1Qycxd
         d4ZDiHXDzuqVNG2ZMN6cTSr780RZcQKxt2mframb2kCoxG2QJ9YI0MU42CuwKWxcaSxH
         gqOw==
X-Gm-Message-State: AC+VfDw7GgdpqKtH2CHT6zs/l0K/whPmkAihhyKpWoynO3L6BFlmWQ14
	I3uPPvY4xHwLdfHwTeDvyH9CYFrTT5xxgBZykR/R0Gy4KfOyzptWRY0djuw5
X-Google-Smtp-Source: ACHHUZ5Q2i36lOTQoxksDqzmUkgzCVCQBYtDj0BOz1PlpryKoRvZHW+yRcsnnJZf380CZinvb/j84GySesTbKdoba2o=
X-Received: by 2002:a17:90b:3b8b:b0:252:7114:b37a with SMTP id
 pc11-20020a17090b3b8b00b002527114b37amr18311704pjb.47.1684184041725; Mon, 15
 May 2023 13:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515204833.2832000-1-andrii@kernel.org>
In-Reply-To: <20230515204833.2832000-1-andrii@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 15 May 2023 13:53:50 -0700
Message-ID: <CAKH8qBtbpp+Ns0M-L-w5tP7XxzB8=vBvvg_dvS0bwv1Bs=qJaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: improve netcnt test robustness
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 1:48=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Change netcnt to demand at least 10K packets, as we frequently see some
> stray packet arriving during the test in BPF CI. It seems more important
> to make sure we haven't lost any packet than enforcing exact number of
> packets.
>
> Cc: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

I was gonna try to count only icmp packets in the bpf program, but _GE
works as well :-)

> ---
>  tools/testing/selftests/bpf/prog_tests/netcnt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/netcnt.c b/tools/test=
ing/selftests/bpf/prog_tests/netcnt.c
> index d3915c58d0e1..c3333edd029f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/netcnt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/netcnt.c
> @@ -67,12 +67,12 @@ void serial_test_netcnt(void)
>         }
>
>         /* No packets should be lost */
> -       ASSERT_EQ(packets, 10000, "packets");
> +       ASSERT_GE(packets, 10000, "packets");
>
>         /* Let's check that bytes counter matches the number of packets
>          * multiplied by the size of ipv6 ICMP packet.
>          */
> -       ASSERT_EQ(bytes, packets * 104, "bytes");
> +       ASSERT_GE(bytes, packets * 104, "bytes");
>
>  err:
>         if (cg_fd !=3D -1)
> --
> 2.34.1
>

