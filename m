Return-Path: <bpf+bounces-6566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783476B7C7
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E691C21055
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B023DE02;
	Tue,  1 Aug 2023 14:33:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658962AE31;
	Tue,  1 Aug 2023 14:33:26 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC34210D;
	Tue,  1 Aug 2023 07:33:23 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40fbf360a9cso12380361cf.3;
        Tue, 01 Aug 2023 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900403; x=1691505203;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDo6NJS9VEeM84PmvihTXLobm68FopvExTulz0R8ct8=;
        b=bLesp76m1APdrFxL8ln9YoiGW561rJNeGDmbfjKoeZME64ClpL81FGKHCoV/aGdEwm
         SdZ/z3F6r9M2t3wJxb3bhcApWIOlWc93XPyR9Q2kiSU0Cirl0Z+l02t4D/wqA/sdKeoI
         aMRG5XMpXp9y9IV11GB5+u3EtqKnWPxwxY9U+Perhepbl0Yc2PfGUK0obbbw/3yzZdIj
         rq+NnUW+f18Q+33r9fjKXP8/jK55XnuGhGcJsWakaZt+AXr6ez5sZwFOtDKKC1l5aF56
         +0oxrkKVIgUkCg/hsLULAe+zjJBR//ZkSwgG6OD4W3TOB71cOyXKIjrl/iXTlEX+2r/e
         uL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900403; x=1691505203;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDo6NJS9VEeM84PmvihTXLobm68FopvExTulz0R8ct8=;
        b=gci7JOjzECPA37lTFN+0eAoxSYNTO7o6WiRItzXRxLrMfq1pELYQa8ULMiK8T2DLdf
         PEHUGTQMW+nLNr/aX33zrAwmAQCy8qXRQTX8g6Uxsz/lLhliBWae/3AA4YCtT6rN0gZB
         WF5kJv9GrgW1K7yJP2yC9YwIs5eNZcpRpH2fLmA9G4NxlzLSEBGNia54soXzdQ/1SbNK
         EI+W5paBVIUExxo30KgactjAAHwMVsMovYsC1l/ACUNInnGFAXhD+Bl2gdSI9uro+s9U
         1NTBgIFmi8NlFg3+AkolEfq57MEBlAWk//a8/pF+r2EMuWRCkts9EPnEBbh93pNC/78L
         pcBg==
X-Gm-Message-State: ABy/qLaVLlj6r6fGbojMXT8k8e83aj77pG57mvcW9bi9Pyy4nyxHjnzA
	fn7ANYqK6zNR/qLYHuj/8B4=
X-Google-Smtp-Source: APBJJlEm7mnctVwlPoCJwXcjKYa8FLXeuIsxclWFmNJO0qK/1Fyl0MoAmtjmPUOx5Vzhh/eLbi2+6g==
X-Received: by 2002:ac8:5701:0:b0:403:397c:9071 with SMTP id 1-20020ac85701000000b00403397c9071mr19155140qtw.63.1690900402664;
        Tue, 01 Aug 2023 07:33:22 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id h10-20020ac85e0a000000b00406bf860430sm4420398qtx.11.2023.08.01.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:33:22 -0700 (PDT)
Date: Tue, 01 Aug 2023 10:33:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Yue Haibing <yuehaibing@huawei.com>
Message-ID: <64c917b26625_1bf0a42947f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230801133902.3660-1-yuehaibing@huawei.com>
References: <20230801133902.3660-1-yuehaibing@huawei.com>
Subject: RE: [PATCH net-next] udp: Remove unused function declaration
 udp_bpf_get_proto()
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

Yue Haibing wrote:
> commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
> left behind this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

