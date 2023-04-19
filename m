Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD06E7C31
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjDSOSt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjDSOSq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 10:18:46 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF42D5BBF
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 07:18:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-32b482bbc26so17427825ab.1
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681913908; x=1684505908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLma1Uv0Fhe5bMT+wuMFjI0fhtMUG6op+fMooZAc+L4=;
        b=D83uz5A+mswNEQGTG9arS2x8HOlW9gw0CIBF3Kb0LFvpTflm+1GV9cM6QfboZakI+m
         Ir7yhpQWcaAfHhoM3CRHpL+3iMy18ZZhUcT3oV4cbj3fBGBGyHOlmAp0jVZYDBHs+k0h
         0uXQlKO/rqhxGk6TqtcQwbHImzTsbfrX5i1GqoqRV2FlCRsxcilIuuTzWmbRSE6cqp1x
         ldZ0AbtZ6XfwBMCl4By/w8oPU8dKrYMEtfK8tUM+biIRnYJv61IqaFxfNZnJ7jKGuA8d
         RslWV6bA5zwgcYNR6LGXudn/jsCtHY3ocvypcrwXxau4jOt9amncPfIOp3esy74K0e7P
         HBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913908; x=1684505908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLma1Uv0Fhe5bMT+wuMFjI0fhtMUG6op+fMooZAc+L4=;
        b=bgR2IbevEp4kwIY8c46noj02Az8wo2xhG50Ct5K/rkTSxa4c1IwKOlHaJZRi4apfpD
         9FG2cSrv3bZt0AmeyQzHgnptbz+SneC71vXJKOhfsl3rR7saHpEkjkpYjmqlx47R9CFQ
         UnMP3z2qieBV+7iT92i0OsFV1KWv4j64JyjXKF6vJqtJY6Mz3ZoClTxxb2t5DZcgbYZE
         n5Yx+E0ZZJUPXaOdJo04YRyI7HSPoaqbw0EIgIcbwKLBtPX9aK1e8mKGfFILa1pHWuHW
         cX7CfIw5gTDQnEre6pIWtMtNPSBax0Lox3/a4HuisPVwD3rhfRZ95tJiQjZxGB/jiib4
         f22A==
X-Gm-Message-State: AAQBX9dbE1Gza5ek4oUuqStLP5afwSM8fquRwxiMvYdrflPU6PnrPR1s
        cmbVu8+dS4vTlRrGOdh9hnv3rQV9nMSjd0lsLzBPLQ==
X-Google-Smtp-Source: AKy350aRxLEIXGTMv/boTqT28uGh3qXNbMOqYQdTlj2lqj7u13qtPC4wBTOEDU8LwyN5LNS5cQuRvQTogOlnXquC+6k=
X-Received: by 2002:a92:c749:0:b0:32c:87c5:e737 with SMTP id
 y9-20020a92c749000000b0032c87c5e737mr33771ilp.6.1681913907881; Wed, 19 Apr
 2023 07:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <ZD2HjZZSOjtsnQaf@lore-desk> <CANn89iK7P2aONo0EB9o+YiRG+9VfqqVVra4cd14m_Vo4hcGVnQ@mail.gmail.com>
 <ZD2NSSYFzNeN68NO@lore-desk> <20230417112346.546dbe57@kernel.org>
 <ZD2TH4PsmSNayhfs@lore-desk> <20230417120837.6f1e0ef6@kernel.org>
 <ZD26lb2qdsdX16qa@lore-desk> <20230417163210.2433ae40@kernel.org>
 <ZD5IcgN5s9lCqIgl@lore-desk> <3449df3e-1133-3971-06bb-62dd0357de40@redhat.com>
 <CANn89iKAVERmJjTyscwjRTjTeWBUgA9COz+8HVH09Q0ehHL9Gw@mail.gmail.com> <ea762132-a6ff-379a-2cc2-6057754425f7@redhat.com>
In-Reply-To: <ea762132-a6ff-379a-2cc2-6057754425f7@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 19 Apr 2023 16:18:16 +0200
Message-ID: <CANn89iJw==Y9fqhc0Xpau_aH=Uq7kSNv8=MywdUgTGbLZHoisQ@mail.gmail.com>
Subject: Re: issue with inflight pages from page_pool
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     brouer@redhat.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
        pabeni@redhat.com, bpf@vger.kernel.org,
        lorenzo.bianconi@redhat.com, nbd@nbd.name,
        Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 19, 2023 at 4:02=E2=80=AFPM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:

> With TCP sockets (pipes etc) we can take care of closing the sockets
> (and programs etc) to free up the SKBs (and perhaps wait for timeouts)
> to make sure the page_pool shutdown doesn't hang.

This can not happen in many cases, like pages being now mapped to user
space programs,
or nfsd or whatever.

I think that fundamentally, page pool should handle this case gracefully.

For instance, when a TCP socket is closed(), user space can die, but
many resources in the kernel are freed later.

We do not block a close() just because a qdisc decided to hold a
buffer for few minutes.
