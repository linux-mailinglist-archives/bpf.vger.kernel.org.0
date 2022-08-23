Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6035359D261
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiHWHib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiHWHi3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 03:38:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DD9D103
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 00:38:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r22so11562755pgm.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 00:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=BXFFqMOep562nL3kaZ6SA9aq7Ca/urF6A0YoulL59Fo=;
        b=LcnNA5MX9tjfvWUTnzLjSfjNpteXQG+l9yN9lPZyXCZ+YHUeJXY+OTZx4nvJ8ubd9D
         CFYEfhyIsyVWqZChusyOdOdpTJzF6Z7tmeBl6ufUo1I34TFEkpcMYfsgAtkdEQa7oc3E
         r/hLUGwqh5Pr3IMjGt0nvl4/ZjYpxUtsUJw/XO2CBVAJMpbmf8KdVQam5r3zpXSvy/4f
         nsc6ApPYBKub3rf2zDwFoC2zL93NfrEwJyujh5GGdClsfCNjYHFJbudktTq0RzDXgJ9T
         wtCUNX10beZmAv9GGRHz7LbZvTNa3rHHfj/+1ZC4hLOY/XAmv9HsjzaYKrIYY5Dl4MHj
         hb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=BXFFqMOep562nL3kaZ6SA9aq7Ca/urF6A0YoulL59Fo=;
        b=vq81eS/CgJX0gN3mtKhMooAgYe9Kq1xKPgZq09x+Ze1wMQfbvZ/8cp8cjny16FW4Ko
         8rtoIq38whOUTCfjekhs62nP2QlMZqsR/9lb+Dv2GogVZvlDkoaxvbJowbu+feDUlbuu
         mSLzu+L5T6TX+zuYWt75D/JYy5UubHOcPGdjQ5y1kMiEX7BHK2f/zdLGY2iKGRfh6E5M
         VrB/RPyTfFYFFGoe1VVAGxHCYA4PWiXCByrplyoQoVuaxya2f9rVpiiReOfZz2RZPt1z
         ibIL/3XUEVzinE1rcWLuzkXDon/aMqQZ5+zjKO6E5Jl90CYOiBbO1uQsBy/Y5QoBMgRv
         74ig==
X-Gm-Message-State: ACgBeo1wjFXGXDeVI+0WQUkzqZkS2jvTW0VrOQdE9z1bwnh7piLD49ku
        W63oUe/RpRrxekVlGNoxsow=
X-Google-Smtp-Source: AA6agR6zA1DxEeYZeQ5AwcH6Mlc5r/DPWVciLVnb7J7n5NPEikOKrmtb75tjzCn+av4+2Ldq7LrxGw==
X-Received: by 2002:a05:6a00:1688:b0:52b:cf1f:807a with SMTP id k8-20020a056a00168800b0052bcf1f807amr23691105pfc.21.1661240306748;
        Tue, 23 Aug 2022 00:38:26 -0700 (PDT)
Received: from localhost ([98.97.33.232])
        by smtp.gmail.com with ESMTPSA id js5-20020a17090b148500b001f1f5e812e9sm9268808pjb.20.2022.08.23.00.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:38:25 -0700 (PDT)
Date:   Tue, 23 Aug 2022 00:38:24 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Message-ID: <630483f08be3e_2ad4d720887@john.notmuch>
In-Reply-To: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
References: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
Subject: RE: [PATCH v2 bpf-next 0/4] flow_dissector: Allow bpf flow-dissector
 progs to request fallback to normal dissection
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Shmulik Ladkani wrote:
> Currently, attaching BPF_PROG_TYPE_FLOW_DISSECTOR programs completely
> replaces the flow-dissector logic with custom dissection logic.
> This forces implementors to write programs that handle dissection for
> any flows expected in the namespace.
> 
> It makes sense for flow-dissector bpf programs to just augment the
> dissector with custom logic (e.g. dissecting certain flows or custom
> protocols), while enjoying the broad capabilities of the standard
> dissector for any other traffic.
> 
> v2:
> - Extend selftests/bpf/progs/bpf_flow.c to exercise new ret code
> 
> Shmulik Ladkani (4):
>   flow_dissector: Make 'bpf_flow_dissect' return the bpf program retcode
>   bpf/flow_dissector: Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode for
>     flow-dissector bpf progs
>   bpf: test_run: Propagate bpf_flow_dissect's retval to user's
>     bpf_attr.test.retval
>   selftests/bpf: test BPF_FLOW_DISSECTOR_CONTINUE
> 
>  include/linux/skbuff.h                        |  4 +-
>  include/uapi/linux/bpf.h                      |  5 +++
>  net/core/flow_dissector.c                     | 16 ++++---
>  tools/include/uapi/linux/bpf.h                |  5 +++
>  .../selftests/bpf/prog_tests/flow_dissector.c | 44 ++++++++++++++++++-
>  .../prog_tests/flow_dissector_load_bytes.c    |  2 +-
>  tools/testing/selftests/bpf/progs/bpf_flow.c  | 15 +++++++
>  .../selftests/bpf/test_flow_dissector.sh      |  8 ++++
>  8 files changed, 89 insertions(+), 10 deletions(-)
> 
> -- 
> 2.37.2
> 

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
