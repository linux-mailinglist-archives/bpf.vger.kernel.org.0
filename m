Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E04610705
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 03:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJ1BB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 21:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiJ1BB4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 21:01:56 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47D68CE9;
        Thu, 27 Oct 2022 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1666918907;
        bh=8S1EPvOt3DpO5fDz/fB5bXm5o9idewNaR5FZjqAbmOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vOZ91FsxQTzEpoPna7nknqY8LrhAwCFP3He97uxnHqjA+6od2WAjbTf54/FRQ5ZAq
         3K6GXjAdgtDQu/n7sWPRxje+5yEqme4YDYlPXS/FMd3IkGxPkM553YtLtVvWkrM0Ib
         xQUQW0FTjyRfJcl2FV6amAvrcOimM6eU8H9b0xVQ=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 6AB683B; Fri, 28 Oct 2022 09:01:42 +0800
X-QQ-mid: xmsmtpt1666918902t35ua7lof
Message-ID: <tencent_92599297262AE4AF18A39988330606425408@qq.com>
X-QQ-XMAILINFO: MaZu5Xhaz90xPHHdCxmOvaFJpbArNwKEAJ6LR9dowB/JF0NU5eertJtSzgpiME
         M2+SQRq8+dWKfcSx5vdSxBwK3PJoyeKKwzcvGx7s6aCUq66wtz26mTZ25XsXSV6g3t60ykjWs7/K
         kp64t+M3Hb/HdljWKbQdJLU/6y2TF+Gw4QXE6ot78MhqSDLYI8qDfRjHWsXUG+XDRAnQXkDQU14R
         KbCyXdZn3TrDl8s8BoTVg5ZpQ0hMQTtegWL6c58pzVn9JPdqmvQSAkncPixVhwzf+8/z1CkNO+ZG
         hMmHx/iTWDVizlg2KTZok1hEATpKlVxQaGI2UJ+j+xNRQEvuvWRU29lohk+4Gx9FAtwLtEiOr0N3
         FZht5mM2mqY7UziSoxnmn/8WUJdMzE8ox8zZTv2fkdZD4NSXSc8LwMhMzJA7I61q2E3GrtwU8x+x
         Dkycp4esXgZm0EaTfGuEZxfW0CObMKhuLpz20/NaCXWCo2IPGWF0qdO5ziW9Vwpyq9TJKAABLCkX
         X3ByVa/5G1VpMLN/32g9YdpmYDgXNPx9AdoMsOVwZhDnNFXC+Q9o2GuSSmpo1zFnGkUP47RK2zXk
         rCAHY8B73jtqgAn6w9BC+vvhQ3zt10i2n0MUHl8ID6bBDcJg7NUiuLdZzJikSjQ+OIieT5lGjh9z
         hzcxm92xAlHSq56nnp83VIVXud9K3Zyh593muPQiPm3XXS4grl2EpQYLwe6EQgql/xp4sLUldnXj
         q/kgTzi8nbxk/7/xzobJdnfNToOnxR6YtHiYKO6jNk5KXHiZ1A4BkoxnsM3yT88uFytqPrQRcjfE
         aJpdsr15G7OGNOLKCdwRiD0bljuF2Ltqynswq80syoIbtcYirHYlLUb4wXsxfFNG5zUb9dN/sfhe
         8JorK1UC7rYIJDtn4J2+Cvq20bVst6JZ/ciYvEatQh0dRqjfB/SAdYHZKl8VwBGXXN1za8QD3V8W
         +fz/JmTtX88Li5X1T9pPN2gwdbpMl6sWEkHF9pr1Dp6JnZ8NFP9RrpKBVreQzD
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: [PATCH] samples/bpf: Fix sockex3: missing BPF prog type
Date:   Fri, 28 Oct 2022 09:01:42 +0800
X-OQ-MSGID: <20221028010142.101095-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzZAOm8Q4U2vcDjQ7T2_PdoMb5NTWUcL-vzzbXH5tntdOQ@mail.gmail.com>
References: <CAEf4BzZAOm8Q4U2vcDjQ7T2_PdoMb5NTWUcL-vzzbXH5tntdOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for your reply, actually, i tried another method, which can solved
this error, recognize "socket/xxx" as "socket". However, it maybe influence
other BPF prog or not? What do you think the following patch?

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8659,7 +8659,7 @@ static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_n
                return false;
        }

-       return strcmp(sec_name, sec_def->sec) == 0;
+       return strncmp(sec_name, sec_def->sec, len) == 0;
 }
