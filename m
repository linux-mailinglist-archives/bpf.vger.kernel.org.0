Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B56535AA8
	for <lists+bpf@lfdr.de>; Fri, 27 May 2022 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbiE0Hpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 May 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiE0Hpj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 May 2022 03:45:39 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA91F68B8
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 00:45:39 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j6so2566025ilk.11
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=cNjPh17AUOA4nB06iTzeOoQEkdQ9W/e4b2W5oO2JbrLwT/1rP4p/SEbf3JemZ1e839
         OCorzcApITk2yzpDOjEcPu0Fe55jKQBHxkWUraNgm871CNvCUdL/lcGo4d0pndyoNEAZ
         Vco6wycdfX8Efw29fAvzhT7A2FiLHi1rKvCHZ3tYhEij6UpOoVSzWduYNj6wWQrw7Ur2
         c4elQYQU2CBR8gYDpFJw3Fi+mlxSRx/E1aHJASH2hYtgYx2OwvbGe0xPhj4k3VFdVRPs
         zjJyNC110xH4cl7Ao3ZtUlgB+kQFeq3Lck2FxGIUAC/vzqGWJQmANSq/fILNkN2UfOL9
         PqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=ZWbnAvTdek8PyFqoqgvjUDjyEkatTwxFB1mtlZzGBz4vQZ92THReq+iSO8hdStBrTL
         aep/6Z/x2/zC5YGkRM9lloTaBuam/UxdL0BCWGWemUhIc9TvAQseHTt8FDB4f8t/sIR7
         i9XdSpQvAPV44vVo4Qaw+URBvpXq2m7b2q702qLD+6oLvr90Mh0mY39xZDjWx1BZbpM0
         94MZtvg4IOgW4Kx40mYFz3S5fP9wiTtZTI+NyeEHyl0qX9zTAPH68N55g2fH44GLq/A/
         dNiSy7ArBTEKc+Ts85+N6XOjwP590sb9Ng+8pOVWZkQto7JItUxTmIfd0EfkbTevBfJ/
         Xg3g==
X-Gm-Message-State: AOAM533lXyvZ295aQw4dsSN6FmuLDU2CEHItghnAOh7ipSXOWDXuAurh
        3YcvaEoPOiuUDNpWtarQx6/NWoSqTBYmzcUbMXE=
X-Google-Smtp-Source: ABdhPJz4pDIlZ3DME889iVFpxVSFAkA2rkUx6Nhq68kKrNBmtFAcU1mTpJ31MsVRr6YUc71lhbKZZd0wY0HUm8uV++4=
X-Received: by 2002:a05:6e02:1608:b0:2d1:b86c:5b6b with SMTP id
 t8-20020a056e02160800b002d1b86c5b6bmr11596224ilu.304.1653637538420; Fri, 27
 May 2022 00:45:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1525:0:0:0:0 with HTTP; Fri, 27 May 2022 00:45:38
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <electriccoltd@gmail.com>
Date:   Fri, 27 May 2022 03:45:38 -0400
Message-ID: <CA+GWTwa92sqbNZ1c-32ofVSYMfJ4p9RZsE9ieHDJS90nS+E7bQ@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Can I engage your services?
