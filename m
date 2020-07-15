Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC963220CA2
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgGOMFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgGOMFn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 08:05:43 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2E3C061755
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 05:05:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h1so1237781otq.12
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fIgUJOEwl8SPjqh6tIIbJRELmoHHIy8JGC3d8waeLBA=;
        b=QtMXXAoa8y60R2TGNvSsUEdN3zCxspEK7Wdk6/j4In495Yjz9R/PNnI66pM7Mx75Vr
         7YfN6J9bkHUUQYcofLLF+gEA3DvozsM6NrpD5vYC9wH4MHAkHiuTksxx/HtKD9Z/OteC
         zHBiF5JZsLfrL7vQKqQSI7zrZSQedrUfiHPj0kzsopkjpOIPTFJ23dLJlCK9pvM4mtSf
         gD8i4aJjxsl5xhqT3O/nr0mFffaLt1B20mJUKlVy28yoNB4jPGn7+DtQKuQNVOioFsLX
         dzuwA16VnkrUHqgrnF0uVK4BSEH6sI5qoGdrjxwx/nXqmIkTxEF0ee2BYmyDTMntsv1s
         AEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=fIgUJOEwl8SPjqh6tIIbJRELmoHHIy8JGC3d8waeLBA=;
        b=AaEueSM5lcPGsTnz2EaUgOpAMIVJM6TXUbUoodI3T2L48sK5HYy7OoPk9PZbsHTkgY
         FsJ8bQqQ5EeJt+mP2XLMekgS4kWTcF8A3tHVic1It4yRgylVox6lOHayyz88fDYIR/s8
         1HgDpEZO8Nj8V2AucFUP+xxHGk+/Gmm0ilBEZUjCor6jdV3tJEx6vsbabT63Lj18vd3G
         3n/nTR55CyT7wJkR5Cq2pdu+uFjNkFuSgwVaTzI/6VnAf6dCGFSMuAB3Z3On9ufsA+oo
         EmI4ekCxpvMrSa//7vDCXI68arKdEg/mE+jofsNNGs5Dqly28xbJOjwLbxWCjcYwinaL
         qpcg==
X-Gm-Message-State: AOAM530fNHYht0rWQk87qJkZgHSTF2maGB+PK1bFGPQmYZB+oGcpJNvn
        DHQLyhVMXHA3pNRcEo3wwSbFtg7+VM59rLPlcAQ=
X-Google-Smtp-Source: ABdhPJwuiM8d31oMsiY2CkOluy59g+IRHvhPOkW0vLijxZ6U/JBmvYHzu8bt2YpJgrJ5D6c1e6/YbI1LLD1qZ70URyU=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr8284193otr.90.1594814742910;
 Wed, 15 Jul 2020 05:05:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: yoshikoazumi9@gmail.com
Received: by 2002:a9d:67:0:0:0:0:0 with HTTP; Wed, 15 Jul 2020 05:05:42 -0700 (PDT)
From:   yoshiko azumi <yoshikoazumi09@gmail.com>
Date:   Wed, 15 Jul 2020 15:05:42 +0300
X-Google-Sender-Auth: recrTYE6f42Wh3va1ziMAe3SfnA
Message-ID: <CAEDqf2fb8iWwuWVZSRxmhH_c0UW-VK3-i1xYYJfjvAt4CNZhKg@mail.gmail.com>
Subject: =?UTF-8?B?6Imv44GE5LiA5pel?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

44GT44KT44Gr44Gh44Gv44CBDQrlj4vmg4XjgajmjKjmi7bjgpLnlLPjgZfkuIrjgZLjgb7jgZnj
gILjgZPjga7miYvntJnjga/jgIHmgrLjgZfjgb/jgavmuoDjgaHjgZ/mhJ/mg4XnmoTjgarjg6nj
g4Djg7zjga7prYLjgYvjgonmm7jjgYTjgabjgYTjgb7jgZnjgILjgZPjga7miYvntJnjga/jgIHn
p4Hjga7mnIDlvozjga7poZjjgYTjgpLlrp/ooYzjgZnjgovjgZ/jgoHjgavjgIHopqrliIfjgafl
loTmhI/jga7jgYLjgovkurrjgYvjgonjga7mgJ3jgYTjgoTjgorjgYzlv4XopoHjgafjgZnjgILj
gajjgabjgoLmhJ/orJ3jgZfjgabjgYTjgb7jgZnjgILnp4Hjga/np4Hjga7kurrnlJ/jgpLoqpPj
gYTjgb7jgZnjgILjgZ3jgZfjgabjgIHjgYLjgarjgZ/jga7lv4PjgYzntJTnsovjgafoqqDlrp/j
gafjgYLjgovpmZDjgorjgIHjgYLjgarjgZ/jgYzjgZPjga7ml6XjgpLlvozmgpTjgZfjgarjgYTj
gZPjgajjgpLntITmnZ/jgZfjgb7jgZnjgILml6XmnKzjga7jgYLjgZrjgb/jgojjgZfjgZPjgZXj
gpPjgafjgZnjgIINCkdvb2dsZeOBp+OCouODoeODquOCq+WMu+WtpuOBrueglOeptuOCkuOBl+OB
puOBhOOCi+OBqOOBjeOBq+OBguOBquOBn+OBruODoeODvOODq+OBq+WHuuOBj+OCj+OBl+OAgeOB
guOBquOBn+OBruOCouOCq+OCpuODs+ODiOOCkuimi+OBpOOBkeOBvuOBl+OBn+OAguengeOBr+S5
s+aIv+OBqOWWieOBrueZjOOBq+mVt+aZgumWk+e9ueaCo+OBl+OBpuOBiuOCiuOAgeOBmeOBueOB
puOBruWFhuWAmeOBi+OCieOAgeengeOBrueKtuaFi+OBr+acrOW9k+OBq+aCquWMluOBl+OBpuOB
hOOBpuOAgeaYjuOCieOBi+OBq+OAgeengeOBr+S7leS6i+OBjOOBp+OBjeOBquOBhOOBi+OAgeOC
ueODiOODrOOCueOBruWkmuOBhOOBk+OBqOOCkuOBmeOCi+OBk+OBqOOBjOOBp+OBjeOBvuOBm+OC
k+OAguWMu+W4q+OBq+OCiOOCi+OBqOOAgeW9vOOCieOBr+engeOBq+asoeOBrjLjgYvmnIjplpPk
vY/jgpPjgafjgYTjgarjgYTlj6/og73mgKfjgYzjgYLjgovjgZ/jgoHjgIHnp4Hjga/jgZPjga7m
qZ/kvJrjgpLliKnnlKjjgZfjgabjgIHjgojjgorlsJHjgarjgYTnibnmqKnjgajmhYjlloTlm6Pk
vZPjgbjjga7np4Hjga7pgbrnlKPjgpLjgZnjgbnjgabniqDnibLjgavjgZfjgZ/jgYTjgajoqIDj
gaPjgabjgYTjgb7jgZnjgILmr43jga7jgYTjgarjgYTotaTjgaHjgoPjgpPjga7lrrbjgYvjgono
grLjgabjgonjgozjgIHjgqLjg6Hjg6rjgqvluILmsJHjgajntZDlqZrjgZfjgIHjgYzjgpPjga7n
l4XmnJ/jgYzpnZ7luLjjgavmgqrljJbjgZfjgZ/jgZ/jgoHjgafjgZnjgILnp4Hjga/kuqHjgY/j
garjgaPjgZ/lpKvjgagyMOW5tOmWk+WtkOS+m+OBquOBl+OBp+e1kOWpmuOBl+OBvuOBl+OBn+OA
guOCouODoeODquOCq+Wkp+S9v+mkqOODr+OCt+ODs+ODiOODs0QuQ+OBpzEx5bm06ZaT5YON44GE
44Gf5b6M44CB6Ie05ZG955qE44Gq6Ieq5YuV6LuK5LqL5pWF44Gn5Lqh44GP44Gq44Gj44Gf5b6M
5pyf44Gu44Ki44Os44Kv44K144Oz44OJ44Op44Od44O844Or44CCDQoyMDEz5bm044Gr5b2844GM
5Lqh44GP44Gq44Gj44Gf5b6M44CB56eB44Gv5YaN5ama44GX44Gq44GE44GT44Go44KS5rG644KB
44CB57aZ5om/44GX44Gf44GZ44G544Gm44Gu5omA5pyJ54mp44KS5aOy5Y2044GX44CB5ZCI6KiI
ODMw5LiH44OJ44Or77yIOOeZvuS4h+ODieODq+OAgTMw5LiH57Gz44OJ44Or77yJ44KS56eB44Gu
6Z2e5bGF5L2P55So5Y+j5bqn44Gr6aCQ44GR44G+44GX44Gf44CC5Lqh44GP44Gq44Gj44Gf5aSr
44Gu5YWE5byf44Gv44CB56eB44GL44KJMiw4MDAsMDAw44OJ44Or44KS5aWq44Gj44Gm6YCD44GS
5Ye644GX44G+44GX44Gf44CC55+l44KJ44Gq44GE44GG44Gh44Gr44CB56eB44Gu5aSr44Gv56eB
44Gu5ZCN5YmN44Gr44GE44GP44KJ44GL44Gu44GK6YeR44KS5q6L44GX44G+44GX44Gf44CC56eB
44Gu5ZCN5YmN44Gr5q6L44GV44KM44Gf5ZCI6KiI6YeR6aGN44GvMzAw5LiH44OJ44Or44Gn44GX
44Gf44CCDQo4MzDkuIfjg4njg6vjgIHjgZ3jgozjgpLjg4jjg6vjgrPjga7np4Hjga7pnZ7lsYXk
vY/nlKjlj6PluqfjgavpoJDph5HjgZfjgb7jgZnjgILjgaDjgYvjgonnp4HjgYzku4rmjIHjgaPj
gabjgYTjgovnt4/poY3jga84MzDkuIfjg4njg6vjgafjgZnjgILkuqHjgY/jgarjgaPjgZ/lpKvj
ga7lhYTjga/jgIHnp4HjgpLmsJfjgavjgZvjgZrjgIHjgZ/jgaDmrbvjgpLmnJvjgpPjgafjgYTj
govjgaDjgZHjgarjga7jgafjgIHkuozluqbjgajkvZXjgoLjgZfjgarjgYTjgZPjgajjgavjgZfj
gb7jgZfjgZ/jgILnp4Hjga/lvJXpgIDjgZfjgZ/kuIrntJrnnIvorbfluKvjgajjgZfjgabmiJDl
ip/jgZfjgb7jgZfjgZ/jgYzjgIHlvbzjga/np4HjgpLjgbvjgajjgpPjganlvbnjgavnq4vjgZ/j
garjgY/jgZfjgb7jgZfjgZ/jgILnj77mmYLngrnjgafjga/jgIHlvbzjga/np4HjgYzjganjgZPj
gavjgYTjgovjgYvjgIHoh6rliIbjga7pgZPjgYzjgo/jgYvjgonjgZrjgIHmsJfjgavjgZfjgabj
gYTjgb7jgZvjgpPjgILnp4Hjga/jgZPjga7kurrnlJ/jgafku5bjgavoqrDjgoLjgYTjgb7jgZvj
gpPjgIHjgZ3jgZfjgabjgZ3jga7mnIDjgoLoia/jgYTpg6jliIbjga/jgIHmlK/miZXpioDooYzj
gYzoqLzmmI7jg6zjgr/jg7zjgafnp4Hjgavmib/oqo3jgZXjgozjgZ/mib/oqo3jgZXjgozjgZ/k
urrjgavos4fph5HjgpLop6PmlL7jgZnjgovjgZPjgajjgYzjgafjgY3jgovjgajnp4Hjgavmib/o
qo3jgZXjgozjgZ/jga7jgafjgIHos4fph5HjgYzkuJbnlYzkuK3jganjgZPjgafjgoLlvbzjgb7j
gZ/jga/lvbzlpbPjga7pioDooYzlj6PluqfjgavpgIHph5HjgZXjgozjgb7jgZnjgILnj77lnKjj
gIHnl4XmsJfjga7msrvnmYLjgpLlj5fjgZHjgabjgYTjgovjg63jg7Pjg4njg7Pjga7nl4XpmaLj
gafjg6njg4Pjg5fjg4jjg4Pjg5fjgpLkvb/nlKjjgZfjgabjgYTjgb7jgZnjgILjgZ3jgozku6Xm
naXnp4Hjga/oqbHjgZnog73lipvjgpLlpLHjgaPjgabjgYrjgorjgIHnp4Hjga7ljLvluKvjga/n
p4HjgavnlJ/jgY3jgovjga7jgasy44GL5pyI44GX44GL44Gq44GE44Go6KiA44GE44G+44GX44Gf
44CC44Gd44KM44Gv44CB44GT44Gu44GK6YeR44Gu5bCR44Gq44GP44Go44KCNjDvvIXjgYzjgYLj
garjgZ/jga7pgbjmip7jgZfjgZ/ntYTnuZTjgavmipXos4cv5a+E5LuY44GV44KM44CB5YiG6YWN
44GV44KM44KL44Gu44KS6KaL44KL44Gu44GM56eB44Gu5pyA5b6M44Gu6aGY44GE44Gn44GZ44CC
5oWI5ZaE5Zuj5L2T44Gu6ZaT44Gu44Gd44KM44Gu44Gd44KM44Ge44KM44CB5L6L44GI44Gw6LKn
44GX44GE5a6244CB5q+N44Gu44GE44Gq44GE6LWk44Gh44KD44KT44Gu5a6244CB56eB44GM55Sf
44G+44KM44Gf5aC05omA44CB56eB44Gv44GT44Gu5LiW55WM44GrMuOBi+aciOS7peS4iuS9j+OC
k+OBp+OBhOOBquOBhOOBruOBp+OAgTQw77yF44KS5L2/44Gj44Gm6Ieq5YiG44KS5Yqp44GR44KL
44GT44Go44GM44Gn44GN44G+44GZ44CC56eB44GM5rGC44KB44Gm44GE44KL44Gu44Gv44CB5pyA
5b6M44Gu6aGY44GE44KS5Y+244GI44Gm44GP44KM44KL6Kaq5YiH44Gn5YWD5rCX44Gq5Lq644Gn
44GZ44CC5LuK5pel44GC44Gq44Gf44Gr5omL57SZ44KS5pu444GP5YmN44Gr44CB56eB44Gv44GT
44Gu44Oh44OD44K744O844K444KS6YCB44KL44GT44Go44KS56WI44KK44CB56eB44Gu57K+56We
44GM6Ieq5L+h44KS5LiO44GI44Gm44GP44KM44G+44GX44Gf44CC56eB44Gu5pmC6ZaT44Gv6ZaT
44KC44Gq44GP57WC5LqG44GZ44KL44Gu44Gn44CB56eB44Gv5a6J5b+D44GX44Gm5LyR44KA5YmN
44Gr44GT44Gu5rG65a6a44KS44GX44G+44GX44Gf44CC6L+U5L+h44GM44GC44KK5qyh56ys44CB
5pSv5omV44GE6YqA6KGM44Gu6YCj57Wh5YWI5oOF5aCx44Go44CB44GT44Gu5Lu244Gr6Zai44GZ
44KL6YCj57Wh5pa55rOV44Go6YCj57Wh5YWI44KS44GK55+l44KJ44Gb44GX44G+44GZ44CC56eB
44Gv44G+44Gf44CB44GC44Gq44Gf44Gr5qip6ZmQ5pu444KS55m66KGM44GX44G+44GZ44CC44GT
44KM44Gv44CB44GC44Gq44Gf44GM44GT44Gu6KiA44Gj44Gf6LOH6YeR44Gu5pyA5Yid44Gu5Y+X
55uK6ICF44Gn44GC44KL44GT44Go44KS6Ki85piO44GX44G+44GZ44CC56We44Gv56eB44Gu576K
6aO844GE44Gn44GZ44GL44KJ44CB44GE44Gk44KC56eB44Gu44Gf44KB44Gr56WI44Gj44Gm44GP
44Gg44GV44GE44CC56eB44GM44GC44Gq44Gf44Gr5b+F6KaB44Gq44Gu44Gv44CB44GC44Gq44Gf
44GM5Y+X44GR5Y+W44Gj44Gf6LOH6YeR44GM44Gd44Gu55uu55qE44Gu44Gf44KB44Gr5L2/44KP
44KM44KL44Go44GE44GG56eY5a+G44Gu5L+d6Ki844Gn44GZ44CC5LuK5pel44CB5L+h6aC844GZ
44KL44Gu44Gv6Zuj44GX44GE44Gn44GZ44GM44CB56eB44Gu57K+56We44GM44Gq44Gc44GT44KM
44KS5Y+X44GR5YWl44KM44CB44GT44KM44Gr44Gk44GE44Gm44GC44Gq44Gf44Gr44Oh44OD44K7
44O844K444KS6YCB44KL44GT44Go44KS5om/6KqN44GX44Gf44Gu44GL44CB56eB44Gr44Gv44KP
44GL44KK44G+44Gb44KT44CC56eB44Gu44GK6YeR44Gn6YCD44GS44Gm44CB56eB44Gu6aGY44GE
44KS5Y+244GI44Gq44GE5Lq644GM5qyy44GX44GP44Gq44GE44GL44KJ44Gn44GZ44CC44GC44Gq
44Gf44GM44GT44Gu5Lu244Gr44Gk44GE44Gm56eB44GM6YCj57Wh44GZ44KL5pyA5Yid44Gn5pyA
5b6M44Gu5Lq644Gn44GZ44CC56We44Gv56eB44Gu576K6aO844GE44Gn44GZ44GL44KJ44CB44GE
44Gk44KC56eB44Gu44Gf44KB44Gr56WI44Gj44Gm44GP44Gg44GV44GE44CC56eB44Gu5bm444Gb
44Gv56eB44GM56uL5rS+44Gq5Lq644Gu55Sf5rS744KS6YCB44Gj44Gm44GE44Gf44GT44Go44Gn
44GZ44CC6L+U5L+h44GM6YGF44KM44KL44Go44CB5ZCM44GY55uu55qE44Gn5YCL5Lq644G+44Gf
44Gv57WE57mU44KS6Kq/6YGU44GZ44KL5L2Z5Zyw44GM55Sf44G+44KM44G+44GZ44CC56eB44Go
5LiA57eS44Gr44GT44KM44Gr6YCy44KT44Gn44GP44Gg44GV44GE44CC5oWI5ZaE5Zuj5L2T44Gu
44Gf44KB44Gr44GT44Gu44GK6YeR44GuNjDvvIXjgpLkvb/nlKjjgZfjgIHjgZ3jgozjgbvjgann
ibnmqKnjgpLmjIHjgZ/jgarjgYTjgojjgYbjgavliqrlipvjgZfjgIE0MO+8heOCkuiHquWIhueU
qOOBq+S9v+eUqOOBl+OBpuOBj+OBoOOBleOBhOOAguOBl+OBi+OBl+OAgeengeOBr+OBk+OBruWP
luW8leOBq+OBguOBquOBn+OBruS/oemgvOOCkuW/g+OBi+OCieaxguOCgeOBpuOBhOOBvuOBmeOA
guOBk+OBruWPluW8leOBr+OAgeengeOBruiHqueUseOBquW/g+OBqOelnuOBi+OCieOBruiqoOWu
n+OBquS6uuOBqOOBl+OBpuaPkOahiOOBl+OBvuOBmeOAguOCiOOCjeOBl+OBkeOCjOOBsOOBlOS6
huaJv+OBj+OBoOOBleOBhOOAgue3iuaApeOBruOBlOi/lOS/oeOCkuOBiuW+heOBoeOBl+OBpuOB
iuOCiuOBvuOBmeOAgg0K44KI44KN44GX44GP44CBDQrjgojjgZfjgZMNCg==
