Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A796C6F3681
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEATKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEATKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:10:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C5C1708
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:10:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7550dca3so5025819276.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682968228; x=1685560228;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWIlxJQRcWnLjOIUDTJbSfh4XgVjMf4ajKI0PtK8Upc=;
        b=O5lvsEqN0MYH1blpGOOkkgbT7JMg7SG6dFxDvl1pKmykIQ2G7Qo+bPG6vIoyPEC4Hu
         07Uf6FDJnXk5bsb4GFbJWJ/ecXoVx18tvZ77eZTy3JjlMHNFxf0h7msxqsI5VrnL+esb
         hIkq+KbGoYHjLTFJrjeGLtT2f/A2VCyzG7hI0mp93UoLo3hL01glx4M91CZTL1Hy2Ar/
         jhQZVXNQnvqs4fniC6P8Hsm9XQxwa7dY0ilns6p+b4NaqsjS5sET2SWMLCohNlmdgehE
         cPZ6UWUfcjZHWaoR7DQ+Ae4OY2tH6jL350L6oK48zfa7NmRKTjVx72en7N2GbNpIDqce
         K9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968228; x=1685560228;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWIlxJQRcWnLjOIUDTJbSfh4XgVjMf4ajKI0PtK8Upc=;
        b=ftsFJiu0f830inbvsbP5dZDIXCR0u56EmoXM3UsPEwDwjtc5AvRkQvaPqRSip7uKz3
         FAGocGxRk2Uc+JNu5ti8YuaRkdPTKQF29XfMkAXkFG5oT/FYKPJsBg4yt9XLjQu4G+51
         z3PZLnigCHbU0yxGV/GXyFpVijL0Snpoa7fEDEIw37706U4cWQH9LW0kw14zX4NQWTvC
         81ANSnZ91Xt8r8wPwC8+lBEB736h5/EjaWSjlpBx4SLq4vy76aVxzyK2vCfTJTqpNNw+
         t6sVnSjfVdOc+YXX+hau+Xik1cEjevBA+myYtKSOl0g8gs8+6bYAtTkmpXRCWYu6PBZ9
         PhKw==
X-Gm-Message-State: AC+VfDyXdjzkAAK5DVbIEyaJweSmgMBXo3M2BR4aBbMR6+F2pWY3SBeU
        SqkAhlbNEM1AziK4LEX5a35Q9wJxM+Wk/eUKdtJFOC5XNjjpAaENN3yiFqY72ekODTf/Tc/cIsm
        mSBE6AyN7afKFh8ioTQEiNZlGKHqn0aDwkw96W5tJVsPcW+t0tg==
X-Google-Smtp-Source: ACHHUZ53eU+ZwpbB3GOckMG4Ir/qJoB+4nw0tZVGSKka6HC9LEaTxUGz7HxTRXKoMNQdqJwJgK3vl9M=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:a002:0:b0:b99:f14b:53c1 with SMTP id
 x2-20020a25a002000000b00b99f14b53c1mr5225513ybh.6.1682968228406; Mon, 01 May
 2023 12:10:28 -0700 (PDT)
Date:   Mon, 1 May 2023 12:10:26 -0700
Mime-Version: 1.0
Message-ID: <ZFAOojsT93ZxwNu3@google.com>
Subject: [ANN] bpf development stats for 6.4
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

Here is my attempt to apply Jakub's scripts to analyze mailing list activit=
y.
See the following link for mode details and methodology:
https://lore.kernel.org/netdev/4d47c418-32d9-4d6a-9510-a6a927ebe61b@lunn.ch=
/T/#t

tl;dr: people/companies receive higher score when they participate in revie=
ws
(vs only sending patches).

For now, I'm providing the numbers without any analysis.

Individual Rankings
-------------------

Top 10 reviewers (thr):             Top 10 reviewers (msg):
   1. [103] Alexei Starovoitov         1. [189] Alexei Starovoitov
   2. [ 64] Andrii Nakryiko            2. [185] Andrii Nakryiko
   3. [ 46] Stanislav Fomichev         3. [ 98] Stanislav Fomichev
   4. [ 36] Daniel Borkmann            4. [ 87] Martin KaFai Lau
   5. [ 32] Martin KaFai Lau           5. [ 66] Jakub Kicinski
   6. [ 27] Yonghong Song              6. [ 59] Kui-Feng Lee
   7. [ 27] Jakub Kicinski             7. [ 53] Jiri Olsa
   8. [ 24] John Fastabend             8. [ 49] Yonghong Song
   9. [ 24] Jiri Olsa                  9. [ 45] Daniel Borkmann
  10. [ 20] Kui-Feng Lee              10. [ 43] David Vernet

Top 15 authors (thr):               Top 10 authors (msg):
   1. [ 32] Andrii Nakryiko            1. [201] Andrii Nakryiko
   2. [ 21] Kal Conley                 2. [124] Xuan Zhuo
   3. [ 19] Jesper Dangaard Brouer     3. [110] Jesper Dangaard Brouer
   4. [ 18] Xuan Zhuo                  4. [107] Kui-Feng Lee
   5. [ 15] David Vernet               5. [101] Eduard Zingerman
   6. [ 15] Alexei Starovoitov         6. [ 86] Yafang Shao
   7. [ 14] Dave Marchevsky            7. [ 77] John Fastabend
   8. [ 14] Eduard Zingerman           8. [ 62] Alexei Starovoitov
   9. [ 14] Lorenzo Bianconi           9. [ 53] Kal Conley
  10. [ 13] Martin KaFai Lau          10. [ 52] Martin KaFai Lau
  11. [ 13] Daniel Borkmann
  12. [ 12] Kui-Feng Lee
  13. [ 11] Song Yoong Siang
  14. [ 11] Yafang Shao
  15. [ 10] Dave Thaler

Top 15 scores (positive):           Top 15 scores (negative):
   1. [1330] Alexei Starovoitov        1. [106] Xuan Zhuo
   2. [812] Andrii Nakryiko            2. [ 91] Kal Conley
   3. [632] Stanislav Fomichev         3. [ 91] Kui-Feng Lee
   4. [427] Martin KaFai Lau           4. [ 64] Dave Marchevsky
   5. [401] Daniel Borkmann            5. [ 64] Yafang Shao
   6. [380] Jakub Kicinski             6. [ 51] Song Yoong Siang
   7. [363] Yonghong Song              7. [ 44] Florian Westphal
   8. [334] Jiri Olsa                  8. [ 43] Joanne Koong
   9. [316] Kui-Feng Lee               9. [ 40] Jiri Olsa
  10. [261] Arnaldo Carvalho de Melo  10. [ 38] Feng zhou
  11. [248] John Fastabend            11. [ 37] Dave Thaler
  12. [233] Toke H=EF=BF=BDiland-J=EF=BF=BDrgensen    12. [ 37] "D. Wythe"
  13. [228] "Michael S. Tsirkin"      13. [ 36] "Masami Hiramatsu (Google)"
  14. [214] Kal Cutter Conley         14. [ 36] Yonghong Song
  15. [206] Quentin Monnet            15. [ 32] Daniel Rosenberg

Company Rankings
----------------

Note, company attribution requires mapping from the email to the company.
People who are listed verbatim, feel free to share your company name
over private or public email.

Top 10 reviewers (thr):            Top 10 reviewers (msg):
   1. [195] Meta                      1. [463] Meta
   2. [ 93] Isovalent                 2. [205] RedHat
   3. [ 72] RedHat                    3. [166] Google
   4. [ 71] Google                    4. [161] Isovalent
   5. [ 69] Intel                     5. [149] Intel
   6. [ 19] Huawei                    6. [ 43] nVidia
   7. [ 15] Eduard Zingerman          7. [ 38] Kal Cutter Conley
   8. [ 15] nVidia                    8. [ 33] Eduard Zingerman
   9. [ 14] Kal Cutter Conley         9. [ 33] Huawei
  10. [ 12] Corigine                 10. [ 23] Paul Moore

Top 15 authors (thr):              Top 10 authors (msg):
   1. [134] Meta                      1. [640] Meta
   2. [ 48] Isovalent                 2. [213] Google
   3. [ 45] RedHat                    3. [210] Isovalent
   4. [ 40] Google                    4. [175] RedHat
   5. [ 36] Intel                     5. [164] Alibaba
   6. [ 25] Huawei                    6. [101] Eduard Zingerman
   7. [ 25] Alibaba                   7. [ 94] Intel
   8. [ 21] Kal Conley                8. [ 86] Yafang Shao
   9. [ 14] Microsoft                 9. [ 69] Huawei
  10. [ 14] Eduard Zingerman         10. [ 53] Kal Conley
  11. [ 14] IBM
  12. [ 11] Yafang Shao
  13. [  9] Oracle
  14. [  8] Bytedance
  15. [  8] Jason Xing

Top 15 scores (positive):          Top 15 scores (negative):
   1. [2152] Meta                     1. [147] Alibaba
   2. [1001] Isovalent                2. [ 91] Kal Conley
   3. [906] RedHat                    3. [ 64] Yafang Shao
   4. [831] Intel                     4. [ 44] Florian Westphal
   5. [814] Google                    5. [ 38] Bytedance
   6. [227] nVidia                    6. [ 27] Kui-Feng Lee
   7. [214] Kal Cutter Conley         7. [ 24] Gilad Sever
   8. [160] Corigine                  8. [ 23] <zhongjun@uniontech.com>
   9. [145] Huawei                    9. [ 23] Rong Tao
  10. [122] Eduard Zingerman         10. [ 22] Tiezhu Yang
  11. [111] Bagas Sanjaya            11. [ 20] Puranjay Mohan
  12. [104] Paul Moore               12. [ 19] Lorenzo Stoakes
  13. [ 76] Linux Foundation         13. [ 19] Gerhard Engleder
  14. [ 65] IBM                      14. [ 19] Jason Xing
  15. [ 64] Casey Schaufler          15. [ 16] Xueming Feng

How to reproduce
----------------

This is mostly for myself so I don't forget how to do it next time.

$ git log --oneline | head -n1
ad1d2952b4e0 Re: [PATCH bpf-next 2/2] libbpf: selftests for resizing datase=
c maps

$ git log --oneline --since '02/21/2023' | tail -n 1
e4662930a06f Re: [PATCH bpf-next V3] xdp: bpf_xdp_metadata use EOPNOTSUPP f=
or no driver support

$ git rev-list --count e4662930a06f..master
5687

$ ./ml-stat.py --repo bpf-0.git --db db.json --email-count 5687

$ ./ml-stat.py --repo bpf-0.git --db db.json --email-count 5687 --corp
