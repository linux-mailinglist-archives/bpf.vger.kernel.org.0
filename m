Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232294827BE
	for <lists+bpf@lfdr.de>; Sat,  1 Jan 2022 15:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiAAO2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Jan 2022 09:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiAAO2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Jan 2022 09:28:47 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE5C061574
        for <bpf@vger.kernel.org>; Sat,  1 Jan 2022 06:28:46 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id q14so26295340qtx.10
        for <bpf@vger.kernel.org>; Sat, 01 Jan 2022 06:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=X0pjQO5/9khPeF7+OSED9VX6wPiWgrNrYpQLIZD9AHk=;
        b=FEzTwji0xKIegUdgt+i0C5gr6jwa9IknfCdgnJTp1GliVA0Rq6W8XB9C4KSLDlEcM7
         57q0sakfxKmIAmwbOYI0eAKN8tNs6Ksabs/v21n1t57QhUA0328pu7h6HJ4HZxVLEaMU
         IXU3IYp2JaaN317v++rwU6OYjM0/ceI2GiLitfnubtBWPqaT4fGniVn+ncY2mabZqGIu
         qRCxxT2PU9YlSIW1q3paGAvBeamFv/8Ijzsxp6EkFINGjcVt1mRJvmwLiGgRlgbgQAQX
         BfdaDoSWeqExg2bsIeMPjv7gYQGxuJPImoxnOckaNS7p86XdocoDJp0Ffpt4ZKnaDSiQ
         x8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=X0pjQO5/9khPeF7+OSED9VX6wPiWgrNrYpQLIZD9AHk=;
        b=L4Vi/7K0uh3+FnmBaHO1mwLpCIphPhbzfN/bwzz5lNSwxA6CuTd7HUb4jOFqMk81zz
         XxoBc5B5h96hX1jDxaxPi38IlXwWu+Qi3sNF+C8Ck9TPQB1cOdLCZHc+aVZDJGqLGQgD
         mtnbM2b0vTnlhrPiD52P8UM10zAEi7ES55ObzY7fuSS09SOY5OHyuwz9MoxRvRee3zhQ
         Xf9Tdr2kdQPEdrIQ/cVBj+t8gtQLmrl8roTtlf6Qth3QTzkEo2ufXA6Gx+CuobvTwiFr
         k2KYRK60QTyGWx+S/4236dsBTlR9kD51iHNb5G8Ag37iVxx7rbZCrtuU/mTo2meUhpdp
         f5kw==
X-Gm-Message-State: AOAM531A31C0CfQI9RgUnNcZb1zmLHt+Y3hBuCIMxpEqMNChWxgQfJvU
        ejFMQoUMId7ZDDZjZ1Reeyv/agAPozrwqMjh2w4=
X-Google-Smtp-Source: ABdhPJzhTbWF2c2oCC3GTGAUylEeJrD2BIrPJf1/PIaQQ4/VtVXaWKGothKzFqWvL4ONETyR6ydAy8v/tXqV3IzpXTw=
X-Received: by 2002:ac8:5a51:: with SMTP id o17mr34453999qta.180.1641047326032;
 Sat, 01 Jan 2022 06:28:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:c81:0:0:0:0 with HTTP; Sat, 1 Jan 2022 06:28:45
 -0800 (PST)
Reply-To: crisstinacampell@gmail.com
From:   "Mrs. Cristina Campbell" <barrmercyjohnson2000@gmail.com>
Date:   Sat, 1 Jan 2022 14:28:45 +0000
Message-ID: <CAFvLHNxe1yU53hrJmhF7X7A0U3aK8jX8kVM2=fjB7Z_mkfbVxg@mail.gmail.com>
Subject: =?UTF-8?B?5L2g6IO95biu5oiR5ZCX?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

5Lqy54ix55qE77yMDQoNCuivt+aFouaFouS7lOe7humYheivu++8jOWboOS4uuWug+WPr+iDveaY
r+aCqOaUtuWIsOeahOacgOmHjeimgeeahOeUteWtkOmCruS7tuS5i+S4gOOAguaIkeaYryBDcmlz
dGluYSBDYW1wYmVsbCDlpKvkurrvvIzmiJHlq4Hnu5nkuoblt7LmlYXnmoQgRWR3YXJkDQpDYW1w
YmVsbOOAguS7luabvuWcqOS8puaVpuWjs+eJjOefs+ayueW8gOWPkeWFrOWPuOW3peS9nO+8jOS5
n+aYr+S4gOWQjeS4nOS6muWcsOWMuue7j+mqjOS4sOWvjOeahOaJv+WMheWVhuOAguS7luS6jiAy
MDAzIOW5tCA3IOaciCAzMQ0K5pel5pif5pyf5LiA5Zyo5be06buO5Y675LiW44CC5oiR5Lus57uT
5ama5LiD5bm05rKh5pyJ5a2p5a2Q44CCDQoNCuW9k+S9oOivu+WIsOi/memHjOaXtu+8jOaIkeS4
jeaDs+iuqeS9oOS4uuaIkeaEn+WIsOmavui/h++8jOWboOS4uu+8jOaIkeebuOS/oeavj+S4quS6
uuaAu+acieS4gOWkqeS8muatu+WOu+OAguaIkeiiq+iviuaWreWHuuaCo+aciemjn+mBk+eZjO+8
jOaIkeeahOWMu+eUn+WRiuivieaIke+8jOeUseS6juaIkeWkjeadgueahOWBpeW6t+mXrumimO+8
jOaIkeaSkeS4jeS6huWkmuS5heOAgg0KDQrmiJHluIzmnJvkuIrluJ3mgJzmgq/miJHvvIzmjqXn
urPmiJHnmoTngbXprYLvvIzmiYDku6XvvIzmiJHlhrPlrprlkJHmhYjlloTnu4Tnu4cv5pWZ5aCC
L+S9m+aVmeWvuuW6mS/muIXnnJ/lr7ov5peg5q+N5am0L+W8seWKv+e+pOS9k+WSjOWvoeWmh+aW
veiIje+8jOWboOS4uuaIkeW4jOacm+i/meaYr+acgOWQjueahOWWhOihjOS5i+S4gOaIkeatu+WJ
jeWcqOWcsOeQg+S4iuWBmuOAguWIsOebruWJjeS4uuatou+8jOaIkeW3sue7j+WQkeiLj+agvOWF
sOOAgeWogeWwlOWjq+OAgeWwvOaziuWwlOOAgeiKrOWFsOWSjOW3tOilv+eahOS4gOS6m+aFiOWW
hOe7hOe7h+aNkOasvuOAgueOsOWcqOaIkeeahOWBpeW6t+eKtuWGteaBtuWMluW+l+WmguatpOS4
pemHje+8jOaIkeS4jeiDveWGjeiHquW3seWBmui/meS7tuS6i+S6huOAgg0KDQrmiJHmm77nu4/o
poHmsYLmiJHnmoTlrrbkurrlhbPpl63miJHnmoTkuIDkuKrotKbmiLflubblsIbmiJHlnKjpgqPp
h4znmoTpkrHliIbphY3nu5nkuK3lm73jgIHnuqbml6bjgIHlvrflm73jgIHpn6nlm73lkozml6Xm
nKznmoTmhYjlloTnu4Tnu4fvvIzku5bku6zmi5Lnu53lubblsIbpkrHnlZnnu5noh6rlt7HjgILl
m6DmraTvvIzmiJHmsqHmnInkuI3lho3nm7jkv6Hku5bku6zvvIzlm6DkuLrku5bku6zkvLzkuY7k
uI3kvJrkuI7miJHkuLrku5bku6znlZnkuIvnmoTkuJzopb/mipfooaHjgILmiJHmnIDlkI7kuIDn
rJTml6Dkurrnn6XpgZPnmoTpkrHmmK/miJHlnKjms7Dlm73kuIDlrrbpk7booYzlrZjlhaXnmoQN
CjYwMCDkuIfnvo7lhYPnmoTlt6jpop3njrDph5HlrZjmrL7jgILlpoLmnpzmgqjnnJ/or5rvvIzm
iJHluIzmnJvmgqjlsIbov5nnrJTotYTph5HnlKjkuo7mhYjlloTorqHliJLlubbmlK/mjIHmgqjm
iYDlnKjlm73lrrYv5Zyw5Yy655qE5Lq657G744CCDQoNCuaIkeWBmuWHuui/meS4quWGs+WumuaY
r+WboOS4uuaIkeayoeacieWtqeWtkOS8mue7p+aJv+i/meeslOmSse+8jOaIkeS4jeaAleatu++8
jOaJgOS7peaIkeefpemBk+aIkeimgeWOu+WTqumHjOOAguaIkeefpemBk+aIkeS8muWcqOS4u+ea
hOaAgOaKsemHjOOAguaUtuWIsOaCqOeahOWbnuWkjeWQju+8jOaIkeS8muWwveW/q+e7meaCqOmT
tuihjOeahOiBlOezu+aWueW8j++8jOW5tuWQkeaCqOWPkeWHuuaOiOadg+S5pu+8jOaOiOadg+aC
qOaIkOS4uuivpeWfuumHkeeahOWOn+Wni+WPl+ebiuS6uu+8jOS7peS+v+aCqOeri+WNs+WcqOaC
qOaJgOWcqOeahOWbveWuti/lnLDljLrlvIDlp4vov5npobnmhYjlloTorqHliJLjgIINCg0K5Y+q
5pyJ5Li65LuW5Lq66ICM5rS755qE5Lq655Sf5omN5piv5pyJ5Lu35YC855qE44CC5oiR5biM5pyb
5L2g5rC46L+c5Li65oiR56WI56W377yM5L2g5Zue5aSN55qE5Lu75L2V5bu26L+f6YO95Lya6K6p
5oiR5pyJ56m66Ze05Li65ZCM5qC355qE55uu55qE5a+75om+5Y+m5LiA5Liq5Lq644CC5aaC5p6c
5oKo5LiN5oSf5YW06Laj77yM6K+35Y6f6LCF5oiR5LiO5oKo6IGU57O744CC5oKo5Y+v5Lul6YCa
6L+H5oiR55qE56eB5Lq655S15a2Q6YKu5Lu26IGU57O75oiW5Zue5aSN5oiR77ya77yIY3Jpc3N0
aW5hY2FtcGVsbEBnbWFpbC5jb23vvInjgIINCg0K6LCi6LCi77yMDQrmraToh7TvvIwNCuWFi+mH
jOaWr+iSguWonMK35Z2O6LSd5bCU5aSr5Lq6DQrnlLXlrZDpgq7ku7Y7IGNyaXNzdGluYWNhbXBl
bGxAZ21haWwuY29tDQo=
