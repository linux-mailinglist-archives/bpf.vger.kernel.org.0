Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321D549B8D
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiFMSbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbiFMSbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:31:11 -0400
X-Greylist: delayed 329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 07:48:45 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAFFBCBB
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 07:48:45 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.155]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1HuU-1o2PAH2rHe-002pGD; Mon, 13 Jun 2022 16:42:35 +0200
Message-ID: <de4da55b-a074-b375-c41d-413bb19a428b@i2se.com>
Date:   Mon, 13 Jun 2022 16:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [BUG] null pointer dereference when loading bpf_preload on
 Raspberry Pi
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        bpf@vger.kernel.org, jpalus@fastmail.com,
        regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <f038d6f9-b96b-0749-111c-33ac8939a1c0@i2se.com>
 <YqcbgmTmezGM0VPr@shell.armlinux.org.uk>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <YqcbgmTmezGM0VPr@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RUNrFBwO0Rxcmop+xh2sE+cCQBp6k7JRB/aBlkwKSR5DZbbnnuK
 JzNwJOnHUCBbVTQF4vvpq45KCFOfjlvWG+h0CBWrquW+sLSTdcyq/JW9ACJIuLXwXO5jOFn
 n7cX6JIug22sB911HFAVE2Ym19DV+AQ4ibGWGDXOhxUmQB8nP0YeTdozmAuE7DlToDm2xsc
 2ggpSyzOPQFvCUCyDSnWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzokOsTgqhU=:qsIgKmQvGURvx6eca4GQCF
 qtonQCxBOG1f8otpPzDKPWk7zB8KtcQxcYFnfXCAr7AJu881Wax4S1d77iTlWHXkRRJqn383/
 ADm2PhfWJ1VO8IFjT5bDoHlUGm28tZRw3L/pp5GN84j8eE/z1p54E2XnRVNgSrNCHZJ8ftqcf
 UL0Ew2LABcTIelIOF3XyAuQsFZJdE9sJi6UQc/uJZ37Rh1luurl8MLGJR2EJxmIquA6IUPBzE
 JLxWkBv+QjjSziqBQ/ttt9r3dRej9/JAkKCg08kkf0PodpXD7AKQeJeGTyQqyBOawaxTK6uGq
 WNRuE6xk5M3GnR8oWlQqxG/pUB2ub3m18USg+QmznK7gxTwSfhuEpp0zq1m4kFxkVs+qMjNYt
 VrN9dAwU/Fm7KI61AsAObSelk4aJHHwd2FM64WE4V177vJbIVnfO4Hi+dbcO6RfmBJ46hy02G
 +8zXUTQdYhUls4Ngp0WPKTmCDsryEJoX2g1jUOnE4nwVPYwExC7dNt3zqrTfywT8lwicDPWq4
 73IxjyZPlYhDseD9/UQhnhMuLXPSL7xMChNZyEl2mdP60f/gAh20ZU4vPVNxSn6FMJZsPX9Dc
 l8LirM8msZi8TYee8uQ3PtpIUkkmqMvVTQ+6GN961ZvPgwMws+cEdYCKE9vVuTF0f1/1Hxub1
 zDGlFzPjtDF/oNsMqfXMvOurPwcB/Z24953GlDrwa0DJ9YxK/a3guufxJAO0EIyw0x8qYXzJa
 1IAl0uZyhnAgMz2/PDA8UVvX39c7iGvs3U1R1tpIt1QzW7BuUG5BGCvs3rg=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Am 13.06.22 um 13:12 schrieb Russell King (Oracle):
> On Mon, Jun 13, 2022 at 12:22:47AM +0200, Stefan Wahren wrote:
>> It would be nice to get a hint, how to narrow down or which commit might
>> trigger this issue.
> The standard way? git bisect?
>
> So it happens on 5.18.0 and 5.18.3. Presumably it didn't happen with
> 5.17?

in 5.17 there is a libelf dependency (was removed in 5.18), which cause 
a compile issue about missing libelf.h which is only available on my 
host system but not available in my Linaro cross toolchain.

Should i copy the libelf.h somewhere, so the cross compiler finds it?

