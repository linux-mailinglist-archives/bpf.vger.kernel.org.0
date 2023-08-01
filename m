Return-Path: <bpf+bounces-6518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15A76A7AF
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 05:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E3E2817F1
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122AE1C3A;
	Tue,  1 Aug 2023 03:55:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9947E;
	Tue,  1 Aug 2023 03:55:52 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7110FD;
	Mon, 31 Jul 2023 20:55:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76cb0d2fc9cso133735585a.2;
        Mon, 31 Jul 2023 20:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690862150; x=1691466950;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI5ApKmAaEVjVH/lQQslgrHdUJoivEjWSZTwEUMIjGg=;
        b=Ah4suT3qyoCBjj+fWIAiu0pVKzu7TdaF+2Z+TryuoLDeS1C1jNbbK/ZdFD02CwiiUE
         zBwQGTyOunNQ7ZpCGVurAgRkeB2eOiYq0FwwSN+P2YzfvLI5Zb1UxUzdc9zzFIvvhM1R
         pQhLYu2rp/IZzbGVjxJTUM46DH+bZ2Ow+9iPlhLn7Wndt93MbnsnYpIYAE18+wZgwwfw
         x+R2f5dB0P3GoIXA9TQw3CQ7GqTnYHpIaOCksh54DlOzcLXIZdrdLtVeCQvQmDRxPW4a
         jvf2N4lbHcb3Mhv4Q+aOCrOsD+S+jEwpSFQ8mOOBMugyOimMkWHrnY7QibajMavuSjLu
         i/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690862150; x=1691466950;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bI5ApKmAaEVjVH/lQQslgrHdUJoivEjWSZTwEUMIjGg=;
        b=TO43Ay7wNas7o8XaM4AxWfUzltyPKg/DQvFywMdUkN8GWdkmy3mrtjTrCaK5l+BP9x
         AIrA8waLg5VDaQRbxEpYic5WLzsRNukXUYxMTVC4KuDasYbxpL/vGYQ2wLPBNqbNE/E1
         Ii7/jkbvr8CUodogFfus+jFeGluUG73zv4DxTuzK7MdaYCpIO4yYodAX/+3oJdspSLUW
         Iq2DfEJDGn2RI/vujsh27HmCJeiB1QKexFNnXY/bwM17ZB97wXWs5AqfQUdCpS/fH1gm
         ugQGzq/zb4zmuhU0mJ/WgimWMiJTO0dWViy08MfCESZWZi6fG3JPuFUKUIZtfiHbKP8/
         dm7w==
X-Gm-Message-State: ABy/qLZWDL8I87DmSK/FvV2k7zYVU8PAVOajh2BTXR33bq0sQuMcLQEy
	dx+vi1L/7sUuZNN48rVV52E=
X-Google-Smtp-Source: APBJJlG6tTB3yOwwrFUmEoDsvvSoUgB86ycoDSCxr5yNn6jzOz9iCAJs3o7N2Pztosr6iN7gbf6gpg==
X-Received: by 2002:a05:620a:2847:b0:763:a1e2:127c with SMTP id h7-20020a05620a284700b00763a1e2127cmr13538362qkp.69.1690862150146;
        Mon, 31 Jul 2023 20:55:50 -0700 (PDT)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id k2-20020aa790c2000000b00686dd062207sm8259979pfk.150.2023.07.31.20.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 20:55:49 -0700 (PDT)
Date: Mon, 31 Jul 2023 20:55:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <64c882442b8b0_a427920828@john.notmuch>
In-Reply-To: <20230728105717.3978849-1-xukuohai@huaweicloud.com>
References: <20230728105717.3978849-1-xukuohai@huaweicloud.com>
Subject: RE: [PATCH bpf] bpf, sockmap: Fix bug that strp_done cannot be called
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> strp_done is only called when psock->progs.stream_parser is not NULL,
> but stream_parser was set to NULL by sk_psock_stop_strp(), called
> by sk_psock_drop() earlier. So, strp_done can never be called.
> 
> Introduce SK_PSOCK_RX_ENABLED to mark whether there is strp on psock.
> Change the condition for calling strp_done from judging whether
> stream_parser is set to judging whether this flag is set. This flag is
> only set once when strp_init() succeeds, and will never be cleared later.
> 
> Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/skmsg.h |  1 +
>  net/core/skmsg.c      | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 054d7911bfc9..959c5f4c4d19 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -62,6 +62,7 @@ struct sk_psock_progs {
>  
>  enum sk_psock_state_bits {
>  	SK_PSOCK_TX_ENABLED,
> +	SK_PSOCK_RX_ENABLED,

small nit can be make this SK_PSOCK_RX_STRP_ENABLED? That way its
explicit what we are talking about here.

Otherwise it looks good thanks nice catch.

>  };
>  
>  struct sk_psock_link {
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index a29508e1ff35..7c2764beeb04 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1120,13 +1120,19 @@ static void sk_psock_strp_data_ready(struct sock *sk)
>  
>  int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
>  {
> +	int ret;
> +
>  	static const struct strp_callbacks cb = {
>  		.rcv_msg	= sk_psock_strp_read,
>  		.read_sock_done	= sk_psock_strp_read_done,
>  		.parse_msg	= sk_psock_strp_parse,
>  	};
>  
> -	return strp_init(&psock->strp, sk, &cb);
> +	ret = strp_init(&psock->strp, sk, &cb);
> +	if (!ret)
> +		sk_psock_set_state(psock, SK_PSOCK_RX_ENABLED);
> +
> +	return ret;
>  }
>  
>  void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
> @@ -1154,7 +1160,7 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
>  static void sk_psock_done_strp(struct sk_psock *psock)
>  {
>  	/* Parser has been stopped */
> -	if (psock->progs.stream_parser)
> +	if (sk_psock_test_state(psock, SK_PSOCK_RX_ENABLED))
>  		strp_done(&psock->strp);
>  }
>  #else
> -- 
> 2.30.2
> 

