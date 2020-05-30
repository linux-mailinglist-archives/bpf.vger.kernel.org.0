Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63E21E9273
	for <lists+bpf@lfdr.de>; Sat, 30 May 2020 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgE3QGt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 May 2020 12:06:49 -0400
Received: from sonic302-54.consmr.mail.ne1.yahoo.com ([66.163.186.180]:39028
        "EHLO sonic302-54.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728927AbgE3QGt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 May 2020 12:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590854808; bh=3gwbdpD6fpTnU3AIhQs1dw9/oeXqxu71NA+1nQpVq+I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=OjPwDHUVVPjeLY3f+X2+0Fn5Spa/K2dw6cjxG9oGUo1gBqb/9GSpvf5KZJclrsvdL4HMQYZObPY/5tEpjnkDuvkUhWVzxbDM/8yYCRtdCHSk4yJK8OtH/1iVieSR2JcvhPZxqUnbB2eUovUBiP7PqliUHcdUNK33G2KO+se14STxJa8HJw+vfDNGKOoiGbfmaDezec8ZUCWp1FqIFPYkKQSt9EgOfdKQDdC+bWXGUr0Ewpcr46qMnpfUOLGB3YTwyrzRi6JAR8B+BWgZEzED5JIUhw6zjo8vyWCvuDVC4r+Y/5pgaGxOl0xUPZV2s8+qou8ruHBV3lcVwSf5koFpQA==
X-YMail-OSG: cK5eGeMVM1neuT9pbW0aQfqC1z92p790VwOv2VXegL9k71bT_zWS5UOtOlQ1hhG
 2KRG.z4xHU_6wS_0aC9Jbg.rF6FC1QigB2IPu0hjF8R1OijSqzX2BLmWXFeyuoE3H95ufB4qGg_V
 pizGpu6Ma0ktbpZAWotOCXz_cOSP6AbKfKwz7w5IdorDwnAHF0XoTFsAJZ07XDGCP6CpC7V6uYxk
 F53aZX4tlBnpeIQubMLOyucHK9oj1gbzAVDASdW7jzh3KHKFKvUStYjTKiiKNgAM0GI6q6FBKLSZ
 PwZ7VX8rZxP9.9ar7og53SOaQEIjQrDDdAFnPwO2B9411mVViWL8.6Mt.QgfsU0aCHP6ZVcsa2LP
 zvz5AlYm1iL0xh5UasC2xlX8xgqhwaT4DN4FgVeBy2nQrmvyUZw6OqdG3qEIK6rIVjw.QGlm8p8B
 EDUqyZLbDcB__J4h0c_zyZeo0K3JHUR06WwtmCag7ER15FQFdRItuO_FOZYb00eytK7h9Zs3UoLA
 rwCni7SYcCvWvMemYpi2fwk13VEesECqK8_z4vd2qEEgEqe99Jwffuk9x4s0zEeG27XiJ.GYbVSO
 H00VcEIqn2ctwW_bW8wrk_H8CeUkQN_0Scn10v5Fd0sUNYEfZUYTssEe7a.uyii.TPLTjXP8IwwW
 eoBzrLl0WUk4b.Zv18pmZbijhAk_euzChwrw5686CIigE7.oiChH15cKaeNszEZ2fUdW0U4gTdZp
 wL4K1h3PILas_mdBHRAXkiJ60kP0srWYYiYUQt7qIaHd3uN0OSjVjd6jWZ6dwwGfZZAtnWiRJzHw
 lBc99I8zCc.Cs.mOMfy4K8J6_1W8k7Eof_2AfTEzUUywk2c4rzIfS6xJeoF9ShsszfBvBR.kbTol
 Ouvq51l.Khu20G0ZPDOGAWZhd07D64sJak4o4C9p4jH3_YhnIvuOkVcusMkj5x08yZnvBcMtYROF
 GAl6VKGaQcJL4I_jeUQRDbU201hltbucZy87yQfU3n62MSA.5O78RP9dgCo9I3PSxLkU8ufLR39H
 khbH_TQv5AVkkSmPvPYtj5qNFSLe0gqxaIXTp8aFjEVYsVwWrbuGc8ltgTsmos6AehEG9wSr2pHe
 CGErWAhoti.Q71tbmx7N9iA1TgT89r3U0vaeAVZ7QH4CLhNVyxYO0qEWbqaVD7Zd1EG7ESGlN.uw
 llkgaXhpIBVzxwYMHYK29A0sn6cFb5QuNg8vrm0_ogHm7myjVUrMWktdOSzvfw0rw2X5tP5zrpS2
 1LFwAmJISsP9l3qkilxj7kDEMVbCbkWCibIopTbxcEigxgBsXq4gaYdcaxrWEC2.cjZLbX6JbJF2
 QotFKn48EaWwpV5y3Zzo2GoHRNq7sy026sqsVs.oiJ69G_14wyWkW85qs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sat, 30 May 2020 16:06:48 +0000
Date:   Sat, 30 May 2020 16:04:47 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <mau32@nbvit.in>
Reply-To: maurhinck7@gmail.com
Message-ID: <1936203153.166352.1590854688000@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1936203153.166352.1590854688000.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck7@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
