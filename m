Return-Path: <bpf+bounces-39439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E429738AE
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B449B285AB6
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A97192B76;
	Tue, 10 Sep 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdzymwCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D61EB2F;
	Tue, 10 Sep 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975065; cv=none; b=sbL4Q2wi7VtHkAPDNXYGewvvNM0b9HxnSLYEn05gNst5FXvVblx1U8p264ONP50S1/PmlPFk8JPoOooYh7hY7N2H8AE1JS3ba9tvoSbxg9OeYLfAQSFwPzdgj9vjewOnnGnYDXZzHR3oWGdmc4pYm9FWfKV7F+q5A8THpV+h964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975065; c=relaxed/simple;
	bh=kRjHz7epwOUJHqWVRokIi0ie2XYhwI8RqMuyt+eJmDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loML1TIxO04aoG+Yw0lpYUKMwdHMmhjffcYQwSNaXM/3HD2JJDpiRav3hljFRYCWdyz8e6v1PY1lqVfVbFZ+1kUrntUlhGc5l8K/9heMMRDvqNI8RSUkGlb4LW7aJrHsF3wCKa49JnmW74qzaZ+qzagRvWkD7kxWDhltFE+nHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdzymwCa; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9c3a4e809so50461585a.2;
        Tue, 10 Sep 2024 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725975063; x=1726579863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vAs4JBrfNs6zZ0N76deFNoJwlS2JixdwwSmEsk3usgo=;
        b=TdzymwCaVoEiCAael5l3khjvv48p5fBC/cqBrkFQ5ykzCUEmiC9TklwAMvYtkSG827
         ao4FktDh0TArjRtjgNrbTvggKL3/eIx9Stzah36Ahf+BbVd/eIq/ZcjszN9jTjOBkdz5
         RrXcjWXMpWsmC6b+YQBf/u2C2wFSyHQVZqKn+MAvumZmc047Tvo7pm12Fa+prszUMfd/
         wJqewcHPQVEndCK4AJbHps+v9OwoVRaIkv4K4YyZuozHe/9jQDlkBWXdaV8grFaHxNoM
         teBWSGH7TP1GHphAw0UKD1qXK2WjvQxhU1x54ARY0kRiOTUcNhFDzNfXq4OZ14vLcKlI
         eUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725975063; x=1726579863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAs4JBrfNs6zZ0N76deFNoJwlS2JixdwwSmEsk3usgo=;
        b=c5rL+bSoDItv+2znGEbNV7nAT8WoQiXU892tJD1IZY7HJLN+aBa8dPbEQ8Dxgph/O5
         0PlPPXeSeBwMM4yBd2qmxNB+84xaziantm+PLOAnGGoZCuGWMzplAhYIRNSVLrVuwuIc
         Gip/B0Y2N2Pmxh+1RAOHw9Wc+oIAsQ3tTXE7zek/N8VclM3JFq4SWDzmKmE3L8PsQhd+
         4rEjL3I/e6YWL2mU8b0Et4Xfr/w/Eu7qTmLU66VoNrmup9xkqr4FOREFMtV6CTFoybiP
         wAkzDuNOXZmbXj71WXsSXZsPoOHMo3tN3E9jqHcRJ5ICC2sXUrd+/O4wOvsgzXaWO+BB
         Z1WA==
X-Forwarded-Encrypted: i=1; AJvYcCXjrok+8SxiDRVRx0QbpzYra9sFQAtqzxFVfVXdlFzRKCU6tL5gn3E2cNEmftdBs5/mD8F127A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIK73WUwWZhWIpbwEhRPdqBygm87x+NhwSTvzLKam5iGpRpzd
	tsUhrUAmDgPLitz4/xHtciyOWJYp0tz1fsKWzr7W0H4zQ3r395AMfunXhjbNBz9AZav6/VCpZM8
	grRWbq8fB4uWhNMuP53QS0EXd1K4=
X-Google-Smtp-Source: AGHT+IFkazSJoizNEunDwAuUSymYU/v45DR8DMvyaf4jL4F1ClpkNqq1+TNoJSYphCUYt7TFaTu8ikgUQMzXmOzRL30=
X-Received: by 2002:a05:6214:2c08:b0:6c5:1453:8bfb with SMTP id
 6a1803df08f44-6c528519a2cmr144643536d6.38.1725975063016; Tue, 10 Sep 2024
 06:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910124129.289874-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240910124129.289874-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Sep 2024 15:30:51 +0200
Message-ID: <CAJ8uoz3tx60yLdwujSa2kmAvB+i7tj+HL-BAHgdcRMrXuq_fVA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests: xsk: read current MAX_SKB_FRAGS
 from sysctl knob
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 14:41, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Currently, xskxceiver assumes that MAX_SKB_FRAGS value is always 17
> which is not true - since the introduction of BIG TCP this can now take
> any value between 17 to 45 via CONFIG_MAX_SKB_FRAGS.
>
> Adjust the TOO_MANY_FRAGS test case to read the currently configured
> MAX_SKB_FRAGS value by reading it from /proc/sys/net/core/max_skb_frags.
> If running system does not provide that sysctl file then let us try
> running the test with a default value.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>
> v2: instead of failing the test case when reading frag value from sysctl
>     file did not succeed, use a default count and proceed with test [Magnus]
>
>  tools/testing/selftests/bpf/xskxceiver.c | 43 +++++++++++++++++++++---
>  tools/testing/selftests/bpf/xskxceiver.h |  1 -
>  2 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 92af633faea8..11f047b8af75 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -325,6 +325,25 @@ static bool ifobj_zc_avail(struct ifobject *ifobject)
>         return zc_avail;
>  }
>
> +#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
> +static unsigned int get_max_skb_frags(void)
> +{
> +       unsigned int max_skb_frags = 0;
> +       FILE *file;
> +
> +       file = fopen(MAX_SKB_FRAGS_PATH, "r");
> +       if (!file) {
> +               ksft_print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
> +               return 0;
> +       }
> +
> +       if (fscanf(file, "%u", &max_skb_frags) != 1)
> +               ksft_print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
> +
> +       fclose(file);
> +       return max_skb_frags;
> +}
> +
>  static struct option long_options[] = {
>         {"interface", required_argument, 0, 'i'},
>         {"busy-poll", no_argument, 0, 'b'},
> @@ -2245,13 +2264,24 @@ static int testapp_poll_rxq_tmout(struct test_spec *test)
>
>  static int testapp_too_many_frags(struct test_spec *test)
>  {
> -       struct pkt pkts[2 * XSK_DESC__MAX_SKB_FRAGS + 2] = {};
> +       struct pkt *pkts;
>         u32 max_frags, i;
> +       int ret;
>
> -       if (test->mode == TEST_MODE_ZC)
> +       if (test->mode == TEST_MODE_ZC) {
>                 max_frags = test->ifobj_tx->xdp_zc_max_segs;
> -       else
> -               max_frags = XSK_DESC__MAX_SKB_FRAGS;
> +       } else {
> +               max_frags = get_max_skb_frags();
> +               if (!max_frags) {
> +                       ksft_print_msg("Couldn't retrieve MAX_SKB_FRAGS from system, using default (17) value\n");
> +                       max_frags = 17;
> +               }
> +               max_frags += 1;
> +       }
> +
> +       pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
> +       if (!pkts)
> +               return TEST_FAILURE;
>
>         test->mtu = MAX_ETH_JUMBO_SIZE;
>
> @@ -2281,7 +2311,10 @@ static int testapp_too_many_frags(struct test_spec *test)
>         pkts[2 * max_frags + 1].valid = true;
>
>         pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2);
> -       return testapp_validate_traffic(test);
> +       ret = testapp_validate_traffic(test);
> +
> +       free(pkts);
> +       return ret;
>  }
>
>  static int xsk_load_xdp_programs(struct ifobject *ifobj)
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 885c948c5d83..e46e823f6a1a 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -55,7 +55,6 @@
>  #define XSK_UMEM__LARGE_FRAME_SIZE (3 * 1024)
>  #define XSK_UMEM__MAX_FRAME_SIZE (4 * 1024)
>  #define XSK_DESC__INVALID_OPTION (0xffff)
> -#define XSK_DESC__MAX_SKB_FRAGS 18
>  #define HUGEPAGE_SIZE (2 * 1024 * 1024)
>  #define PKT_DUMP_NB_TO_PRINT 16
>  #define RUN_ALL_TESTS UINT_MAX
> --
> 2.34.1
>
>

