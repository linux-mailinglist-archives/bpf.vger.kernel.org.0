Return-Path: <bpf+bounces-2917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA62736E9E
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E2528129F
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EBC171A9;
	Tue, 20 Jun 2023 14:26:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1D168B0
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 14:26:19 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B44B3
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 07:26:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-519b771f23aso6343506a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687271176; x=1689863176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2wyBTcJR6p7csnloJ91l2fVHCCEzSyNd6gk8W1QMZU=;
        b=IeCrNA1exspDxFBwqnWrzIbklXPs4QqPKOgcO7ttuCtiUkxaOZPrcS6jp7l6dhhuQD
         93+vcVyyvCua+EUGT66gCYA/AczRo9UxREMSJtI/pbc73NAFcPSauR8Gbe+jAIg1bcSv
         fLzHbprAear5HrplJnqUg4JU7xdod2fv4q0oqvGnAa3ZBhiWVPYgdgdtTPG25wPuTWzP
         aAXr5I0SFlHN+JHX7wEAovCY268gbM4jdPsXYi4wfcSn/EEUiGs3WMFFM/cvzHs8agy2
         vck1flEDgI/qXLS8IBdKq7mOIMsWUdhffhPjMH4rDvAKfk4gSema5MePVFbWAH2O+258
         WNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687271176; x=1689863176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2wyBTcJR6p7csnloJ91l2fVHCCEzSyNd6gk8W1QMZU=;
        b=UiTUIMlK23tO23qhsfFek5lTETnxgY4ddMZwOqC2aBHRQ9gldA+4sjjuKHtDEtFXNc
         SEyI0v++Jps28KHruJ/5wC986aQEBCwuNVM0LVE1HPcwmhaDy6MQUWkSO2Pqu0yI5noe
         4eFJw3entUfXZ1x/8Cz9qGPP/a9L8mUfGLnk3nTIavQglDPmdTAyuIpXLFRdoApD0M0s
         yeeURE+/tYXstJ4zsCqXIYgRFnrhXQCNYH3X0K0zKiB/pOXp7n5CsNJDUwkQvjm1hezk
         mn/ElZQMZHbz0Lkw53x9/yhS+XsALMjYnOOqnC6Z1xAZLvv6spbq9H0s9LeJWISry1qE
         Gaqw==
X-Gm-Message-State: AC+VfDzlgbZPRcvpqv/4+njLKav+cyLm+sV6RwQGVaglTbVWuyjbpe+L
	j/xFx0z2GMiZoNSVWr+/7IbdGVlVzcK33QJ9etHSNw==
X-Google-Smtp-Source: ACHHUZ4F6Bo5HQM/coVzb7fcVno2rPqSFsE7C5eCVHJUdGh3D3sd3vLRXEApaqIuSAwaopl7QePrBD+Ai+HPg3lns/w=
X-Received: by 2002:a17:906:9b88:b0:988:8fed:8ae9 with SMTP id
 dd8-20020a1709069b8800b009888fed8ae9mr5845806ejc.37.1687271176657; Tue, 20
 Jun 2023 07:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v2-3-b7c69a342613@isovalent.com> <20230613185647.64531-1-kuniyu@amazon.com>
In-Reply-To: <20230613185647.64531-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 20 Jun 2023 15:26:05 +0100
Message-ID: <CAN+4W8ge-ZQjins-E1=GHDnsi9myFqt7pwNqMkUQHZOPHQhFvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 7:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> The assignment to result below is buggy.  Let's say SO_REUSEPROT group
> have TCP_CLOSE and TCP_ESTABLISHED sockets.
>
>   1. Find TCP_CLOSE sk and do SO_REUSEPORT lookup
>   2. result is not NULL, but the group has TCP_ESTABLISHED sk
>   3. result =3D result
>   4. Find TCP_ESTABLISHED sk, which has a higher score
>   5. result =3D result (TCP_CLOSE) <-- should be sk.
>
> Same for v6 function.

Thanks for your explanation, I think I get it now. I misunderstood
that you were worried about returning TCP_ESTABLISHED instead of
TCP_CLOSE, but it's exactly the other way around.

I have a follow up question regarding the existing code:

    result =3D lookup_reuseport(net, sk, skb,
                    saddr, sport, daddr, hnum);
    /* Fall back to scoring if group has connections */
    if (result && !reuseport_has_conns(sk))
        return result;

    result =3D result ? : sk;
    badness =3D score;

Assuming that result !=3D NULL but reuseport_has_conns() =3D=3D true, we us=
e
the reuseport socket as the result, but assign the score of sk to
badness. Shouldn't we use the score of the reuseport socket?

Thanks
Lorenz

