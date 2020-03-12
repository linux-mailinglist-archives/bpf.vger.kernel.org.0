Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715B4183006
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLMQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 08:16:38 -0400
Received: from sonic316-11.consmr.mail.bf2.yahoo.com ([74.6.130.121]:42323
        "EHLO sonic316-11.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgCLMQi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Mar 2020 08:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584015395; bh=rLzamwWDU6w+ljUNz15IdfH92SpsSZVAbr+GO8Whobg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=t0tDZEJgXfsju0V5ULEJdo4mtoFeaY2PBVRtOS9m7AVsKr0lu6DIUhWR5BPuJ62Lrqflsiwc9BWANDohNdt/Q99AqoqSd2hEefefS8YnWUDlMFXAo8ZMUxKtD+scj5puHmKM+JetOLgOvN0s6cODkFzq/3iiXWsg6QUFGJ9QC6mQ8mZFsVuUU1+V0AcZ3vlZUtdSTFLWSeEy53vG1zebMDi6QstmQy3OQ1TgAPnTtIPqftwkmP9nb6Dye2DHlKNJ614KXRBTfk7Bv37ASNczIQvCd+witdlkl3+im6FJDfn9NLgbw7e1xgadnW58KGKm3NbD3B9XX1Uqo9yT39kMLg==
X-YMail-OSG: cMMO4o8VM1nZVp6kQH8nxn3IT4LO6O7KITlaNrNS81Xn5vkHRchtlEanskT1E81
 qVw8J8F3uPCdZ.xgm8hJx9glxjUTKDSD3yS08GVwxKnRqFKSyv6yZRlenioKMiv636pfRYmqaO5V
 VaMxAdUHIo0Cr21BgwwYhuLjIfks2b3S1yUL3baYNzKLMxLkrlSan0t6CC5Wb22TlRbAtu4ultbH
 dI72dRHu_iNwQBAW7a7JPe2imv6plV.vzy1QSTLIbcnk3pZSPGC7XqkbNcSsfkKW0xy8jEFe8Hu0
 _dXTrHtbajzzK7yMK7zamPE5e78UBzcbCCl2nbnyoJf4dqmvccxtdwLlaICduqGDYPeEW5Tf2lpg
 xhlaiKLAwSFO8dRUf4qdnxxsYt_hF0GRRyt86ufOU_KkQZ_qYV__GvAmLCyJh8GscqzzGQOwnAmc
 9W2uUlUad9OcZQr.eruEYV7a7wugQpTto2u_m7HGic4nfYCQ87l.s_4DEyjKWHQ_TcSSVJ1_hC.1
 fbajNamnCGphP1k7B2rlaadUzUXxxFSZ__MjfWuR2RNoxwQw856bjY2jN_gHKpPa9Bengr4f8VQP
 ETOw6DYLIHIcO0CTGG0RgqVmwKEBvsPi3L1crHkI7kPP2eawT_2zfuR9yHRriLMr5xlP0VvF958r
 zoc637r1f.Rnz0mVfqyfiFID7YvM99tGvcmhkUAO7NmCTZCl.hkO9f6AQi1_Xekafp61gBvaqJ1L
 mYskImeNG4XDz7CCOTzo5VbyXmATFFhwuIQGcrmsPLbUba2Lh8zmVofhbTSKu8Hmtp4NB_V4XpCD
 Lij7alzMyTH4jM1I0X3NH1klqx0e5AaPCOUkgF078T2LoKIi29dIBJ9ZnnZX.DB6UbWfc22QAgOM
 ALqIHAO0leA9Ub1IPfLJqEJEO9rNLqqtuKh8wVz7Io.PfRJC01_HngtO4H.BZkHm2sBXzQOXtMjf
 Vk_VhEd2gUbT0XdCeF3G2PznBAzRS8qdHHDy7xR7FiCyYSIFKjp0ol1zf5udcu_NDPLutQhr3PIn
 bSfwhmaW8Iafq1QPfuxPei6Pi9dvbheBlhYqk_9pPpyCtYUZuWOGgWUqEpLo8mr6ksW7Hn2F8Zgq
 iNHrQP7RuPp2FcyaiaLWmqenq4Iaqd0xHBRHDEzROuuMNxikiFo1zDPOMF2FLw_VdF1VPMymTx9O
 lwD6YjNoRmo4MmYjEZ0qPF3DJrkhygzuwgz1_GmMXN56jSe6SN7805Z1UVxvZdnNAZG7ODcjvKkA
 yEkOTGXl7POQMMx9IjR2LlLCesmzPyqGDNaI.f1ya60_X5Z2fX7_iPstOqu1Zi0XaTL_nsu4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 12 Mar 2020 12:16:35 +0000
Date:   Thu, 12 Mar 2020 12:16:31 +0000 (UTC)
From:   "MR.Abderazack Zebdani" <zebdanimrabderazack@gmail.com>
Reply-To: zebdanimrabderazack@gmail.com
Message-ID: <858399788.2462416.1584015391917@mail.yahoo.com>
Subject: MY GREETINGS TO YOUR FAMILY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <858399788.2462416.1584015391917.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Greetings My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is not a h=
oax mail and I urge you to treat it serious.This letter must come to you as=
 a big surprise, but I believe it is only a day that people meet and become=
 great friends and business partners. Please I want you to read this letter=
 very carefully and I must apologize for barging this message into your mai=
l box without any formal introduction due to the urgency and confidentialit=
y of this business. I make this contact with you as I believe that you can =
be of great assistance to me. My name is Mr.Abderazack Zebdani, from Burkin=
a Faso, West Africa. I work in Bank Of Africa (BOA) as telex manager, pleas=
e see this as a confidential message and do not reveal it to another person=
 and let me know whether you can be of assistance regarding my proposal bel=
ow because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am skeptical to reveal this particular secret to a stranger. You must assur=
e me that everything will be handled confidentially because we are not goin=
g to suffer again in life. It has been 10 years now that most of the greedy=
 African Politicians used our bank to launder money overseas through the he=
lp of their Political advisers. Most of the funds which they transferred ou=
t of the shores of Africa were gold and oil money that was supposed to have=
 been used to develop the continent. Their Political advisers always inflat=
ed the amounts before transferring to foreign accounts, so I also used the =
opportunity to divert part of the funds hence I am aware that there is no o=
fficial trace of how much was transferred as all the accounts used for such=
 transfers were being closed after transfer. I acted as the Bank Officer to=
 most of the politicians and when I discovered that they were using me to s=
ucceed in their greedy act; I also cleaned some of their banking records fr=
om the Bank files and no one cared to ask me because the money was too much=
 for them to control. They laundered over $5billion Dollars during the proc=
ess.

Before I send this message to you, I have already diverted ($10.5million Do=
llars) to an escrow account belonging to no one in the bank. The bank is an=
xious now to know who the beneficiary to the funds because they have made a=
 lot of profits with the funds. It is more than Eight years now and most of=
 the politicians are no longer using our bank to transfer funds overseas. T=
he ($10.5million Dollars) has been laying waste in our bank and I don=E2=80=
=99t want to retire from the bank without transferring the funds to a forei=
gn account to enable me share the proceeds with the receiver (a foreigner).=
 The money will be shared 60% for me and 40% for you. There is no one comin=
g to ask you about the funds because I secured everything. I only want you =
to assist me by providing a reliable bank account where the funds can be tr=
ansferred.

You are not to face any difficulties or legal implications as I am going to=
 handle the transfer personally. If you are capable of receiving the funds,=
 do let me know immediately to enable me give you a detailed information on=
 what to do. For me, I have not stolen the money from anyone because the ot=
her people that took the whole money did not face any problems. This is my =
chance to grab my own life opportunity but you must keep the details of the=
 funds secret to avoid any leakages as no one in the bank knows about my pl=
ans.Please get back to me if you are interested and capable to handle this =
project, I am looking forward to hear from you immediately for further info=
rmation.
Thanks with my best regards.
Mr.Abderazack Zebdani.
Telex Manager
Bank Of Africa (BOA)
Burkina Faso.
