Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78D6EC063
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjDWO0y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 10:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDWO0t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 10:26:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBC211D;
        Sun, 23 Apr 2023 07:26:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a5197f00e9so29945375ad.1;
        Sun, 23 Apr 2023 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682259997; x=1684851997;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDbIntu1UOpJwHdFve9fpGJWyayD8KIlufUr0WwNJSo=;
        b=Ijgdn5SI4/jYVJ/JoB3fYabmjKi8mK5UBs9FGq6kbTAEqR/557qSm824tCrQW2a/5d
         GNWGzps4K/u7aLe8YAZuHRtNuuHoBJzce+87l5GU+pHBUeRZGq7knP5S5+myY1qU38Pf
         Gyi7oy0ICXuC66GlsvpxaEiuOITcVzHWIumVrFt3lRQE+fUbVj85EEGejxG+KjBnFlvb
         e5W+hRsxu438NJoBGwCkGw2vYS/vWp8yd0W3sPxUyuHAryVqinV3AiIRrdOKmlVzzBRV
         zHTUgd+g4LYWcHswJnDcWExkQ/XCZoJNQGBOTGbR372/WgxXCILdDdLrBbPtzlNbZ2on
         yMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259997; x=1684851997;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hDbIntu1UOpJwHdFve9fpGJWyayD8KIlufUr0WwNJSo=;
        b=QLxjkBYxuJyGDHc7AMWhprrhMr8uMgQl6w6QbDicWjMt2saSAiVw1B1QLEQ+wJ+s9v
         ygyGmBWnTvC/j2rSWZFjCqix4AJM4fUyDpEVJT+mhUOAfE9+OORRCESXnGF9pXDy8LoB
         nNPz5Yc/sdNxEnO/mc2oML919zcV5+uaJL137wkaZ77OuoATZ0YKLFVeOzZkRzmPeS06
         xcfxojXoJnj9gpF+cK/aA0Gws3xA81IJPQGSzO57Vg3j46ngrfNbz0hitPbUIKd3Q6J6
         KwZII/P2hx1iy0qj8gafg3oVdi0NzXFEcfEdB/Saft/OPO6klNqeWkfcGPs1xGMIOj1r
         aCsQ==
X-Gm-Message-State: AAQBX9cOjkIOzGR9sPFhIdY8hyOznfyTQPGVjmAx1n7dwH4HSHJURlaw
        czak0VG96qn76xQjveXJ5Tk=
X-Google-Smtp-Source: AKy350aoN241w7nbxKmiEzOtYF0nSPMYkpeFuUU9y0F40NjrExcFXuUWa/u9dTd8fj7PzRYupvy6kQ==
X-Received: by 2002:a17:902:e5cd:b0:1a6:5487:3f97 with SMTP id u13-20020a170902e5cd00b001a654873f97mr13878348plf.64.1682259996750;
        Sun, 23 Apr 2023 07:26:36 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:5905:623a:c41:59e1])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b001a6801fd9easm5136730pli.176.2023.04.23.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:26:36 -0700 (PDT)
Date:   Sun, 23 Apr 2023 07:26:35 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        bagasdotme@gmail.com, maxtram95@gmail.com, john.fastabend@gmail.com
Message-ID: <6445401b297a1_19af02083@john.notmuch>
In-Reply-To: <20230422172054.3355436-2-joe@isovalent.com>
References: <20230422172054.3355436-1-joe@isovalent.com>
 <20230422172054.3355436-2-joe@isovalent.com>
Subject: RE: [PATCH bpf-next v5 2/2] docs/bpf: Add LRU internals description
 and graph
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

Joe Stringer wrote:
> Extend the bpf hashmap docs to include a brief description of the
> internals of the LRU map type (setting appropriate API expectations),
> including the original commit message from Martin and a variant on the
> graph that I had presented during my Linux Plumbers Conference 2022 talk
> on "Pressure feedback for LRU map types"[0].
> 
> The node names in the dot file correspond roughly to the functions where
> the logic for those decisions or steps is defined, to help curious
> developers to cross-reference and update this logic if the details of
> the LRU implementation ever differ from this description.
> 
> [0]: https://lpc.events/event/16/contributions/1368/
> 
> Signed-off-by: Joe Stringer <joe@isovalent.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
