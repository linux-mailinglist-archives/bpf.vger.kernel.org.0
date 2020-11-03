Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496282A4DE1
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 19:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgKCSIG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 13:08:06 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53407 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgKCSIG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 13:08:06 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D2A82F49;
        Tue,  3 Nov 2020 13:08:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 03 Nov 2020 13:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:to:cc
        :subject:from:date:message-id; s=fm1; bh=rMYJLeewpKSl7PjZkUWmhWD
        BHM+s/h409vxsCzOPf3U=; b=Jx/3ugQrlD5yPRVFJWvcSlSSHUQrMUJ5NsaKXG+
        wLlBmHAyDn+4pF/P3sNd4h3j9SaqNLyeNpVgrc29lNuDO1VaD5QJAoi2CB7e7eRH
        iwrVxufsyRQxztO+fnhqgThBI1g/Kf5Hg0YoqMFnlU7tg0QGx1b5IU27eZXTEsqp
        MtEH4AbohggHQTUaNonjS/570c44iodY4uUSHS4dnAKXZKNfHf5pEt0wt+dnJfVt
        UeMQxaXzIZWy4okVoqcTL81ttGJzJgztRR3Zv0s5PWHmCkNVNfqfGhAqjwE+TFka
        f35jrNQz9//VoyZ3HEKI49n6M2EGmP1bf8ShHSn/loFEy9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rMYJLe
        ewpKSl7PjZkUWmhWDBHM+s/h409vxsCzOPf3U=; b=cMF5blKGd/Ty1/b1gbAXH/
        prS0Zf1GOnQHEhIfie97YG+oVadM8BK1uTNZ+nz/B/7SuDNlkB1Rw/7Dl1iAYmv7
        1bfbB5iZvP+Swa6JKG7CimVzzXWlr9ZHo4rcHfrweTDWBWt4eLlVCU3btm9BrIoo
        Sg4lLl4VZKj6GkXoIw754O0GXIdmqsBIB2AI8duBRAaj8D3KvCoOLIyuQH7AK9k+
        YKQrIR8QIu/dI2kQAkQx4XDmqzvYiW19kl9IlNEtgfQ0lpBDYR5yhKPaZ6SaPsQG
        NkTwqbvreLo9eFArfzWdKV8j9ueqFBzX0JJ/QR4p18yd73xhHzhVaRy5oZ6cekxg
        ==
X-ME-Sender: <xms:hZyhX59SFwbt7kXcAT8JlI59_-woyLwFQL57wO6P45Na6QYY0q1p1g>
    <xme:hZyhX9sjs-Ayrbx6hxyL8JwZ9CcLr2-yXxEMsXn6nURU5uEbfhrzOdxqprR3fNHvI
    5iXzKzI86yAkD0O4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtfedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepgg
    fgtgfvuffhfffksehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepleejkeekkeeiuedtfe
    dvveeuudffkedtvdegudeftdegfeevieetheduffegudfgnecuffhomhgrihhnpehgihht
    hhhusgdrtghomhenucfkphepieelrddukedurddutdehrdeigeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:hZyhX3BewY1HSH2iY7HaKD0ldSbD_lFhqcNnVNcI6ckwbtVPRExK4g>
    <xmx:hZyhX9dBUYrGbxdJR0WBZJMH1k0IR9ttYtsA4pM2X2k91cdOFWD3OQ>
    <xmx:hZyhX-P2N0aSprDKRBKXjxYwVlc3RvSIOlBLB92KvFMGDAxULmyUbA>
    <xmx:hZyhXxbXx92loBgU3tcvmDXBPID2nYuZQV-OySmrUE3yuT4R-Ne0Pw>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id B33F6306468E;
        Tue,  3 Nov 2020 13:08:04 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To:     <bpf@vger.kernel.org>
Cc:     <ast@kernel.org>
Subject: bpf_probe_read*str() may store junk after NUL terminator
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Date:   Tue, 03 Nov 2020 09:45:41 -0800
Message-Id: <C6TTDYNLD7UX.P2O6PJF7OC39@maharaja>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I recently received a bpftrace bug report [0] that identical strings
were being stored as separate entries in maps. I dug into the issue and
it turns out that bpf_probe_read*str() may store junk after the NUL
terminator due to how do_strncpy_from_user() does long-sized copies.

Here is the code in question from lib/strncpy_from_user.c:

       *(unsigned long *)(dst+res) =3D c;
       if (has_zero(c, &data, &constants)) {
               data =3D prep_zero_mask(c, data, &constants);
               data =3D create_zero_mask(data);
               return res + find_zero(data);
       }

This behavior is likely to cause subtle issues in bpf programs so a
kernel fix may be necessary.

Here is a quick reproducer:

str_trailing_bytes.c:

    #include <stdlib.h>
    #include <string.h>
    #include <unistd.h>

    const char s[] =3D "mestring";

    __attribute__((noinline)) void function1(char *first __attribute__((unu=
sed)),
					     char *second __attribute__((unused)))
    {
    }

    int main(int argc __attribute__((unused)), char **argv __attribute__((u=
nused)))
    {
      char *first =3D malloc(64 * sizeof(char));
      char *second =3D malloc(64 * sizeof(char));

      // Make sure bytes after the first string are 0s
      memset(first, 0, 64 * sizeof(char));
      memcpy(first, s, sizeof(s));

      // Make sure bytes after second string are 1s
      memset(second, 1, 64 * sizeof(char));
      memcpy(second, s, sizeof(s));

      function1(first, second);

      free(first);
      free(second);
      return 0;
    }


# bpftrace -e \
  'uprobe:./str_trailing_bytes:function1 { @[str(arg0)] =3D count(); @[str(=
arg1)] =3D count(); exit() }' \=20
  -c ./str_trailing_bytes
Attaching 1 probe...


@[mestring]: 1
@[mestring]: 1


Thanks,
Daniel


[0]: https://github.com/iovisor/bpftrace/pull/1586/
