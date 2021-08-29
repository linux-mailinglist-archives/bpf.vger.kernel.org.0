Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1140A3FA852
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 05:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhH2Dpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Aug 2021 23:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhH2Dpe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Aug 2021 23:45:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC05C061796
        for <bpf@vger.kernel.org>; Sat, 28 Aug 2021 20:44:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s29so4513556pfw.5
        for <bpf@vger.kernel.org>; Sat, 28 Aug 2021 20:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=/bRpxTuoCDHThcBlktEP86KyBftlaEiT8Uv7OKWtgJE=;
        b=hFNLOtBLX+Lk+beWCEFICuA6yckBzgsRBzXV9Hc7Vx9wB1YHwWlJNUXXHt9NI0JB1A
         1kn11ao4/cjhZTPA0pzt9XqiuwVxrpxAp+Lo62GJTe1ZRGl3OdaDcUKEvbCPhb9rNvDG
         Nt5EfMNvHXk+qIBRinq9yDhL3nV157zz65j49U56Gz5J2AM2RJmOfYOEfrg+OX9ha4WD
         xj5N1Q/HU087zeUbVHEM6WeORen19IVqs+UkBXOXkj+6awFxd8eXGE+TUY7g09RLVCcW
         kaphOhve3LPWIJBgvG2MDqB1ZtG6p6N38CnuOuPoC38WYuwacYUTvwUs/NG09teLemy5
         P9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=/bRpxTuoCDHThcBlktEP86KyBftlaEiT8Uv7OKWtgJE=;
        b=pBgmB3RLbnBEPJ0HytapwxwRtMYbPTY3Rrc6dFCUF/w/U+3DWw+kLC2tlWx0HkZ4KA
         BUfj+JkeHgK89/OlsHmWjXR6GjcJh9O718NYyNC9q0GAf7BIV0BN1mXwFWEvAcJAbo2y
         tpiVVyTzbcFDf5Pq9ZKZsE02EH9p6XOiD1Vt6328vBiPViTJGfYcgktklXvsjQjDkFaV
         bSEvNX0W1qtOr17Fu1fbymMFeAQvQnQY5I/ngXjc1zHkp8CP8IeuNF52JiqjIiErsE50
         NUAIlQd4ORwe+TxzvMVAqY5uFyAflig7bGkPkZjlROGHRw1ypK6yR8c40DEszehHpY2h
         i0LQ==
X-Gm-Message-State: AOAM5311Q+XN9pMXcllsMvWOuyBTVQyeyI23MdM3LSJM6286bkb8Mh3H
        VVS9Fn28Y5K37bSLHCLWS9AF9IebU7JVgzEZE28=
X-Google-Smtp-Source: ABdhPJz5uz4GLRz2qq7We0+SFLqHWl3HWf19mZ5oZc5xqIni2Kt+EyUlBeUEqWYVMEXycIsnXAPGj3lqOBY2gK4McQU=
X-Received: by 2002:a63:705:: with SMTP id 5mr14984605pgh.265.1630208682579;
 Sat, 28 Aug 2021 20:44:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:6c05:0:0:0:0 with HTTP; Sat, 28 Aug 2021 20:44:41
 -0700 (PDT)
Reply-To: sararrobrt@gmail.com
In-Reply-To: <CAHiqPVcjWLNOr0C=n4WN14sPVGhB7QFNt9RNgumzR_Abdtipqg@mail.gmail.com>
References: <CAHiqPVcqgvcC+2o+BY8ChZmh6e7jDdHGE3tz_d2hqhFTO1y5Xg@mail.gmail.com>
 <CAHiqPVeL6TLjCDiOC4rovz1AVOvdJAn7j_B_a-RbBZpgiKrdsw@mail.gmail.com>
 <CAHiqPVem-8KZoQy_=88ia251AexAgb1MZgiN0mM3rSTM=F2QGA@mail.gmail.com>
 <CAHiqPVciEMHdof6B4sos5Yx3uoZ73R_zQFt2fE4ZH10FrjnxdA@mail.gmail.com>
 <CAHiqPVexeJrW65oi_0V_ZnZr5Mfa3rqwhvn9Ab4gjhdVhffopA@mail.gmail.com>
 <CAHiqPVdAHLBruUE6qeMNHTpxcLBO0qe9GRsdFVtLpd+m0edRpw@mail.gmail.com>
 <CAHiqPVfKaEcMdB6njt0VmygLjbjNp2vobF=WgyZhXv4RS8ZOtA@mail.gmail.com>
 <CAHiqPVfuuyycmLG8zK2bMS8a0y0VO18Y_0k1HkD0wi8en15Gdw@mail.gmail.com>
 <CAHiqPVfVsQawzzr96PixRkH24f1CpPsg3jcv9O+d3TB5v3jxFA@mail.gmail.com>
 <CAHiqPVcJ4JN+aZGZy6uwn92pUggRjvGs=KJjSLTfR1N0+fuHVA@mail.gmail.com>
 <CAHiqPVdPajC=hxHWR5X2_uvWkiubZKye0Z0xtwaHR2drp9QVEQ@mail.gmail.com>
 <CAHiqPVcfARmYujFVdpt_P-i8dE2+P2ncqY5rWVKmFrQkJenwtA@mail.gmail.com>
 <CAHiqPVcULyR=DQN0moAbWcat7KDXNyetwEt+V+=W-d5bVnGfKQ@mail.gmail.com>
 <CAHiqPVe1DXM=CNXn=k93Mk68Rkz381CC_aPRXhUdP8C-arnYpA@mail.gmail.com>
 <CAHiqPVdZbKEDX4dN719tiBw1EHx7SUBAHAFQW70+3VpCUbFKew@mail.gmail.com>
 <CAHiqPVdudjHKET-C34GJWx4UjaTbfq9CPosuonjhV0T7rMbJNA@mail.gmail.com>
 <CAHiqPVfffCpmozVTHCM_Q+khT_aMo7E7sX5ogn6q5_-NQZaEkQ@mail.gmail.com>
 <CAHiqPVcft5QBtN_Dfzh+yaFCz+RdHO9A_iesheqm=RYkeDXHrg@mail.gmail.com>
 <CAHiqPVffSmK1w4OPe0-aSeuYmMQFfTnSQjmsB5sweTjbk8sCNw@mail.gmail.com>
 <CAHiqPVfA13=ZqVxoPvQDJd_3mz0Ca9XoJFoB-DVd2Lj=cAeWXQ@mail.gmail.com>
 <CAHiqPVdwHr86DjVjLzGQu9N+iqC7XoLuFBG3YisYpKeP--Jp-Q@mail.gmail.com>
 <CAHiqPVfpcS7RUQZtf85d0RmWeW3Hr1Q_DpthL7TLzhKOt4zu3Q@mail.gmail.com>
 <CAHiqPVdRgdu-0icbtnyB_L55e+HQ0DX2i7ihp7H4QEDNA5YAsQ@mail.gmail.com>
 <CAHiqPVfdb2y5dh7BQFq+vTG8dzWwBMbjE0bzDAgj9xiJmhfHpg@mail.gmail.com>
 <CAHiqPVdwqZmuZV7sjFJbd-BtOW7YNDJ5TF5P-LYYaKVoBHNHmg@mail.gmail.com>
 <CAHiqPVcWxXPT-J0TmWjQGHGXmUNccri_ED0s1ka6kF0ZBd+6=A@mail.gmail.com>
 <CAHiqPVcA3fCJQT694+7C0KKGkFTmrGrb07CHGPHGoNRHNuXFLA@mail.gmail.com>
 <CAHiqPVcZkHhmtHNXTzzm78wOeOOuFkSYOjtCf3HU2d5HfvVvpQ@mail.gmail.com>
 <CAHiqPVeYQUPvdwzRyVJ0LuRo-WU6=tAunD+1bv83rrpKCE55Gw@mail.gmail.com>
 <CAHiqPVeFYAz+1pDfS1W1pz-8JTMRY+yM4BpB1fTFyQqSXCW7wg@mail.gmail.com>
 <CAHiqPVennSErNWbnGZBL72TnAcn=a-HG4d8gNkXditWD8zXtvQ@mail.gmail.com>
 <CAHiqPVetpHpCyfPSnZMqmZkqspviwjjB6X1XhD8r_papHh+eSA@mail.gmail.com>
 <CAHiqPVdi1ABJ7cNQTHwCzBN9FtCTdo7U+zABsUWESp3zgAkmDA@mail.gmail.com>
 <CAHiqPVcYJE9WWtO2H4=UydSNKa+J8m8RCmVSQF2S+nMu=z97FQ@mail.gmail.com>
 <CAHiqPVfsSnUDTGVU4L-QT9bxDfXDM5FkQNG=kTszV=8Skw_jag@mail.gmail.com>
 <CAHiqPVex0_3b9EJ7b08=nwOX2hAyuvrgudPSXOrAFUGBqijcdQ@mail.gmail.com>
 <CAHiqPVdY3R7tbc1XO2KQ4zPvy3Q2kAs+gUA_TCJRv1ckx44=eQ@mail.gmail.com>
 <CAHiqPVch8sXuxXbJOjiFn9LG1fBUbVxY1fsx5aUifrb-GO5NhA@mail.gmail.com>
 <CAHiqPVeOfGY9VZdofq0uWF3=Oor1ky=b6s5W+RuYw4ESk6-Y6g@mail.gmail.com>
 <CAHiqPVd0=TZDHSya_C-Z9FVPgMWng9qvWxLyL6SZwY8PGPHaGQ@mail.gmail.com>
 <CAHiqPVceVLLDUiy8s_vURy-h6_zquya7Z08_a86QUtXyHVVbHQ@mail.gmail.com>
 <CAHiqPVcuHuu8TqQC3u-jUE8X5kv9DceS4AOVaX4xOL2DrSo4kA@mail.gmail.com>
 <CAHiqPVfKsUdYUg0a2rRbXZejXxvWXCfxCYojxq7qZAVoXnWn1Q@mail.gmail.com>
 <CAHiqPVeCFuArs-t7Xk3qYcT=rM=z7CV5BtGCwavwgPpsdt1UyA@mail.gmail.com>
 <CAHiqPVc9mRjo0cpu3LNuJCiQPuTEeiu+N+EFh_rCPkZ4jwFYtQ@mail.gmail.com>
 <CAHiqPVdn7tY8eCxS-CRcA4Cuy3P9+OmQJV+Sq6gE=HFBEvgE7w@mail.gmail.com>
 <CAHiqPVePLc3Ce-zfKO+rTepquitVmsn=+Hsvt7io5VW8gig2GA@mail.gmail.com>
 <CAHiqPVcTqxSSTgo3O7re+N4-9aPFeqwFAyrGiAyibgTq6puuEA@mail.gmail.com>
 <CAHiqPVfKhozPyj1ppxm2+Y04U4k9vg8s9HQ=oO=gQdeAxSw9KA@mail.gmail.com>
 <CAHiqPVfj6NL=E-n3jn2DYm+16rkbLrUt4TT2sdwXuOTaEjpmBA@mail.gmail.com>
 <CAHiqPVdJRi4HbjGj8c1Q5RaA9YGzRqyOzcQ9uJsDGYZ7M5aX-g@mail.gmail.com>
 <CAHiqPVfqkHD0tSC6ggtkGtYn_xGM6S4i5Os=SkYWOEykX5b7xA@mail.gmail.com>
 <CAHiqPVcLCd0ten6kG01w29o8JGPSSqdgOT9HED=eo=dL3Vn=VQ@mail.gmail.com>
 <CAHiqPVepiUkz1u2WObe8Kco__eLbWWx-EOYjvXrof-7ALa4XXQ@mail.gmail.com>
 <CAHiqPVfHDTn8JZ5hUYm7+dMGim2+x+ODWKdVPja+ZwUcqzvNDQ@mail.gmail.com>
 <CAHiqPVfBbTZBqQGC5HnLeUw2qAqyAwAs6uRNxwmAqTRZfp=eTw@mail.gmail.com>
 <CAHiqPVcXnY=Vki9=HFh5VDM3wh1pe44tVbbshyP2604b2v_5wg@mail.gmail.com>
 <CAHiqPVfZcz27_19-5wQ8rgnX9yMTdpjsQUM66M+3GKNUAsNP8A@mail.gmail.com>
 <CAHiqPVcrctHNsiDK3bWQKDWvx0-71pqVNmw5r-_tZhYhRLD-Tg@mail.gmail.com>
 <CAHiqPVcnxCkPsWAmsEkrAfZ=sRx53vhHbhEyf9uLFpr2VgrRrw@mail.gmail.com>
 <CAHiqPVdZdnu3QKBeL8xjyCFDHSP8vKuCXjoPFQt+kRSOR28v5A@mail.gmail.com>
 <CAHiqPVdxWE4zUQ7G+FOw410pvNbDaHOs0SsiF_2_Xn+SBLOnZA@mail.gmail.com>
 <CAHiqPVcde3+M=tQQQ7F40o5_zQc1tmDEt9wJSBMYOR+xx82ynQ@mail.gmail.com>
 <CAHiqPVc0dt2uRErMBYWkNMHW6+abfBaxAmdSsoS+koMWB2DBRw@mail.gmail.com>
 <CAHiqPVfcxoCc-_JZH0mJhzHEOOxymy3teD_20T6dKm=1P_qkkw@mail.gmail.com>
 <CAHiqPVf+T-__ir6Kfr7V3DhbzpnKNxYej01H1qd_kBuJVjWT0w@mail.gmail.com>
 <CAHiqPVe6T-ro3yci2GX6v6mVV0LT6Ags-M84EvjErGN91-HKdw@mail.gmail.com>
 <CAHiqPVeVzowL_q=r1ORGKzfLAR4wO-55LgZud1RhkEK2cQsemA@mail.gmail.com>
 <CAHiqPVczeXej2w=zFN6WVynosxcJG6X8XqgzyUkS0ZQGF5j5Vw@mail.gmail.com>
 <CAHiqPVcWBeUrWcA+rBOojoz6B_mYOJ=bb9w1aK8x760GuZiBdA@mail.gmail.com>
 <CAHiqPVeBaF6QxJsZWt5+8Y2p337zdesdCVa_g+6u5ToF+27QwQ@mail.gmail.com>
 <CAHiqPVcrOEUkVso606iFjJY2FOZTxaUMnXC6uT98Jet5gxiVDw@mail.gmail.com>
 <CAHiqPVc4UeiQPr7SoCtVCCrs+z=r3DS8m+JykpaiYrHaZ5=7Tg@mail.gmail.com>
 <CAHiqPVfrWeP3nQrMA16Dvq-DoHLjKDSCE1qUrbpsM8mLzEFHXw@mail.gmail.com>
 <CAHiqPVd2ZYWs4iCMrpDoAGaC+MFQ799Y4XjeZ0SQkNtGu-mR9w@mail.gmail.com>
 <CAHiqPVdacYVUegUY014DxBoO9WVp4rcB0nWTxTpKiqU4FxaGPw@mail.gmail.com>
 <CAHiqPVcyw824RZO7B67nBPvPdnouxg70FUCiWZbFy1t2-Bqv1w@mail.gmail.com>
 <CAHiqPVfKH_H_5WEB43CegyikRMN95ODLMK_8uofxxEo0Vgt2rQ@mail.gmail.com>
 <CAHiqPVfNfhB+a3ft+6Cw-3eqx9MmvXJM-MGXMQVNV=AwGL9Y5w@mail.gmail.com>
 <CAHiqPVe0gs1HwZ1n025U5Mg7hMBPfW8e=u0jOMNv50H0UL_uNg@mail.gmail.com>
 <CAHiqPVfoTRobuhK1sAPUje3UQDGAnD_=CFB-=2EO7rW1imL+_w@mail.gmail.com>
 <CAHiqPVf5aqZtGi=9hCv1=AmfMO_c6Mfy5kANfHzq9U2fh4gpUA@mail.gmail.com>
 <CAHiqPVdvdVbVW88ScyCWFKq6DJTGaNYOPvnCTM_yJU2pt4wHKg@mail.gmail.com>
 <CAHiqPVf2sU1Aouubq+rGobkrbJW49UXoE==VvNfdKNRJTLuBNg@mail.gmail.com>
 <CAHiqPVc1A8VjQ_gHrQc+HZcgPNinQcicsC5Ew5asUCOF2CtC5g@mail.gmail.com>
 <CAHiqPVeo6Zua22Vew75asbS8xv=_4enDDX4hr6V8Wp80rm8gjg@mail.gmail.com>
 <CAHiqPVc74Yk0xYef+WaSzELpphrJgEzQRwd8cFLLLB5fOWAtkQ@mail.gmail.com>
 <CAHiqPVdQ6862szC8yU6bte8zs29hjgMSwDdVMT_sPJoOMLXyeQ@mail.gmail.com>
 <CAHiqPVepMrsV4J0NWxK4eHBUdSFjm_c5sfFz2J6zW3H+Or2Oyg@mail.gmail.com>
 <CAHiqPVf7iTMMnHe=jo0yvszStDX0mdek-COjtcqYtKvjyLT4+A@mail.gmail.com>
 <CAHiqPVdyRSj1fus-0Cm299-frppuBj6TFYw9Ypbz+BuerQaLTQ@mail.gmail.com>
 <CAHiqPVcFdYXshya2iOE-XzM8BHtVz8i6+AnRmsM9JQCNrt66_Q@mail.gmail.com>
 <CAHiqPVeBUKHni-5RRwKV19opDFuTya1gcQ5Df6w-yvY2iV2wew@mail.gmail.com>
 <CAHiqPVcfzcY0d9cxK66WD9S7x=sX4chnLmbtxELUW-ghsiiSrA@mail.gmail.com>
 <CAHiqPVec4ECrGwxK22NQmAQGTqojiePEiH20L5dra2LDSajYWw@mail.gmail.com>
 <CAHiqPVf1gMi4enA06gY4TRWnn8FcLPgKUzSRFuotuzJu9UYrwA@mail.gmail.com>
 <CAHiqPVfz3h_qXVmitKXsO+JxGDHWJKwA8Zm9XeFmai_-LO9PMA@mail.gmail.com>
 <CAHiqPVe9H7C28=OG91wxFjtPEFLyDAmHmVs7iG9iZ=Vnd0T6YA@mail.gmail.com>
 <CAHiqPVe6V8GZiFnePXZ+vH+MtQAZ79fLMFFGa2tejB6Ssnfvrw@mail.gmail.com> <CAHiqPVcjWLNOr0C=n4WN14sPVGhB7QFNt9RNgumzR_Abdtipqg@mail.gmail.com>
From:   "Mrs. Sarah Robert" <goodwllalex@gmail.com>
Date:   Sun, 29 Aug 2021 04:44:41 +0100
Message-ID: <CAHiqPVc2AnsP+b6GpUzZnNgvjAn2zjtL2xWZqwDF0sptUiCfRA@mail.gmail.com>
Subject: Greetings?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My Dear,
I'm Mrs. Sarah H. Robert, 77 years old dying widow from Australia;
that was diagnosed of cancer about 4 years ago. I got your details
after an extensive online search Via (Network Power Charitable Trust)
for a reliable person,  I have decided to donate my late husband WILL
valued of ($5,500,000.00) (Five Million Five Hundred Thousand United
States Dollars) to you for charitable goals. Get back to me if you
will be interesting in carrying out this humanitarian project, so that
i can arrange for the release of the funds to you for the work of
charity before entering the surgery theater. Contact me via
E-mail at :  sararrobrt@gmail.com
Sincerely,
Mrs. Sarah H. Robert.
