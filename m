Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537936456B9
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLGJlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 04:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGJlF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 04:41:05 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599EEC72;
        Wed,  7 Dec 2022 01:41:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 142so345073pga.1;
        Wed, 07 Dec 2022 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BqJ2PMdCdawYIV6fADRyOwU0nVxDeQyk/l1kaGdGTo=;
        b=A9btUXeA46lr/0NfMJlWBb/NAnfTYlQJh2O6rnfrNKYIcjtPpRHD/q48JH05Xp7JZy
         OmDiNdJ4uBodh4kxy2jvWs2t0DuEaKqsEoug7Q2XC8bFx7/DZeTP8Cp4Iy5w24zfUt0i
         R1Na0IVZ0miC6xI2/MNGuFrVbxu5PkjuHMNyYsoDtf05voC14BhKH1JfB2x1YBdS0mO8
         EivQhbRMHuEoBLT4X/Yfvn0xkKyn792qf616N3a4zDgJa8lwtdWqBs8icoJnHlpLH5DC
         NCfSbMaTogwLK2iVQg+zTWfxYRpCStisB1lZNiS1H4XlNDWAoiFDJzuJZggH9/dp2P5u
         QfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BqJ2PMdCdawYIV6fADRyOwU0nVxDeQyk/l1kaGdGTo=;
        b=Ja6HU3UfbUgmiFXyRW3BzMUkXL2FsQybMIFkBELLMS48LF6Dv5hg2RiK1hwVm6Er4O
         JzRt6JEGQLqhKqanV3SwUmGAQjpoYctUSsIZnIXmisXWuTIQJivAE+fLg0KC5BQ+O3I8
         L7GpanwwhKursgKb/MjZvrpcvRIQCkRGuwYzxJVpkkG2N4Ma9AcxTiOp6CHlTMVYUs7T
         sder+sBwoSPuhWgs863/BQwsozFlfenvdM+bFnxo6Oa9df20dfxjb1v1Ixy+xkLS+aCT
         XluHYEqE1+Uf1drHW5GnyKSIBWxFJ9G5Hd25yLR9+BjGHdnPy4WHxBkMWq+6jMjfH3tq
         kWbQ==
X-Gm-Message-State: ANoB5pnX3uuzlOMs/cum/YClMeed7CLDwYF5bxbHqvtUguCpv7Wr//ks
        IdrU2WSdAiyjhAxaYxICxOQbsR5lB60=
X-Google-Smtp-Source: AA0mqf7KnxyMudK/TpTjLC3Ca+2WWjha5g51vKwL0kw1K2lpOSiYbRQHO3jh81Clj+GxbKyubO9Lew==
X-Received: by 2002:a63:e34b:0:b0:477:de0a:3233 with SMTP id o11-20020a63e34b000000b00477de0a3233mr50726146pgj.467.1670406062425;
        Wed, 07 Dec 2022 01:41:02 -0800 (PST)
Received: from debian.me (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00186cf82717fsm14223234plg.165.2022.12.07.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 01:41:01 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E41EE1042C6; Wed,  7 Dec 2022 16:40:58 +0700 (WIB)
Date:   Wed, 7 Dec 2022 16:40:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v3 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Message-ID: <Y5BfqosHSOcvAB2g@debian.me>
References: <20221202114010.22477-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLkXBWWwsr/wfmcK"
Content-Disposition: inline
In-Reply-To: <20221202114010.22477-1-mtahhan@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--oLkXBWWwsr/wfmcK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 11:40:10AM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
>=20
> Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
> including kernel versions introduced, usage
> and examples.
>=20
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
>=20
> ---
> v3:
> - Call out that the user attaches the BPF programs to
>   the sock[map|hash] maps explicitly.
> - Rephrase the note that references the TCP and UDP
>   functions that get replaced.
> - Update simple example to attach verdict and parser
>   progs to a map.
>=20
> v2:
> - Fixed typos and user space references to BPF helpers.
> - Added update, lookup and delete BPF helpers.
> ---
> ---
>  Documentation/bpf/map_sockmap.rst | 493 ++++++++++++++++++++++++++++++
>  1 file changed, 493 insertions(+)
>  create mode 100644 Documentation/bpf/map_sockmap.rst
>=20
> diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_so=
ckmap.rst
> new file mode 100644
> index 000000000000..e2ef3054fe09
> --- /dev/null
> +++ b/Documentation/bpf/map_sockmap.rst
> @@ -0,0 +1,493 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright Red Hat
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF_MAP_TYPE_SOCKMAP and BPF_MAP_TYPE_SOCKHASH
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_SOCKMAP`` was introduced in kernel version 4.14
> +   - ``BPF_MAP_TYPE_SOCKHASH`` was introduced in kernel version 4.18
> +
> +``BPF_MAP_TYPE_SOCKMAP`` is backed by an array that uses an integer key =
as the
> +index to lookup a reference to a sock struct. The map values are sockets.
> +Similarly, ``BPF_MAP_TYPE_SOCKHASH`` is a hash backed BPF map that holds
> +references to sockets.
> +
> +.. note::
> +    - The value type must be __u32 or __u64.
> +    - The value type of __u64 is to support socket cookies.
> +
> +When a user creates these types of maps, they typically attach BPF progr=
ams to
> +them. The allowed programs are:
> +
> +.. code-block:: c
> +
> +	struct sk_psock_progs {
> +		struct bpf_prog *msg_parser;
> +		struct bpf_prog *stream_parser;
> +		struct bpf_prog *stream_verdict;
> +		struct bpf_prog	*skb_verdict;
> +	};
> +
> +.. note::
> +    Users are not allowed to attach ``stream_verdict`` and ``skb_verdict=
``
> +    programs to the same map.
> +
> +The parser programs determine how much data needs to be queued to come t=
o a
> +verdict. The verdict programs return a verdict ``__SK_DROP``, ``__SK_PAS=
S``, or
> +``__SK_REDIRECT``.
> +
> +The attach types for the map programs are:
> +
> +- ``msg_parser`` program - ``BPF_SK_MSG_VERDICT``.
> +- ``stream_parser`` program - ``BPF_SK_SKB_STREAM_PARSER``.
> +- ``stream_verdict`` program - ``BPF_SK_SKB_STREAM_VERDICT``.
> +- ``skb_verdict`` program - ``BPF_SK_SKB_VERDICT``.
> +
> +These maps can be used to redirect skbs between sockets or to apply poli=
cy at
> +the socket level based on the result of a verdict program with the help =
of the
> +BPF helpers ``bpf_sk_redirect_map()``, ``bpf_sk_redirect_hash()``,
> +``bpf_msg_redirect_map()`` and ``bpf_msg_redirect_hash()``.
> +
> +When a socket is inserted into one of these maps, its socket callbacks a=
re
> +replaced and a ``struct sk_psock`` is attached to it. Additionally, this
> +``sk_psock`` inherits the programs that are attached to the map.
> +
> +.. note::
> +	For more details of the socket callbacks that get replaced please see
> +	``net/ipv4/tcp_bpf.c`` and ``net/ipv4/udp_bpf.c`` for TCP and UDP
> +	functions, respectively.
> +
> +There are additional helpers available to use with the parser and verdict
> +programs: ``bpf_msg_apply_bytes()`` and ``bpf_msg_cork_bytes()``. With
> +``bpf_msg_apply_bytes()`` BPF programs can tell the infrastructure how m=
any
> +bytes the given verdict should apply to. The helper ``bpf_msg_cork_bytes=
()``
> +handles a different case where a BPF program can not reach a verdict on =
a msg
> +until it receives more bytes AND the program doesn't want to forward the=
 packet
> +until it is known to be good.
> +
> +Finally, the helpers ``bpf_msg_pull_data()`` and ``bpf_msg_push_data()``=
 are
> +available to ``BPF_PROG_TYPE_SK_MSG`` BPF programs to pull in data and s=
et the
> +start and end pointer to given values or to add metadata to the ``struct
> +sk_msg_buff *msg``.
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +Kernel BPF
> +----------
> +bpf_msg_redirect_map()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +	long bpf_msg_redirect_map(struct sk_msg_buff *msg, struct bpf_map *map,=
 u32 key, u64 flags)
> +
> +This helper is used in programs implementing policies at the socket leve=
l. If
> +the message ``msg`` is allowed to pass (i.e. if the verdict BPF program
> +returns ``SK_PASS``), redirect it to the socket referenced by ``map`` (o=
f type
> +``BPF_MAP_TYPE_SOCKMAP``) at index ``key``. Both ingress and egress inte=
rfaces
> +can be used for redirection. The ``BPF_F_INGRESS`` value in ``flags`` is=
 used
> +to select the ingress path otherwise the egress path is selected. This i=
s the
> +only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_sk_redirect_map()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u=
32 key u64 flags)
> +
> +Redirect the packet to the socket referenced by ``map`` (of type
> +``BPF_MAP_TYPE_SOCKMAP``) at index ``key``. Both ingress and egress inte=
rfaces
> +can be used for redirection. The ``BPF_F_INGRESS`` value in ``flags`` is=
 used
> +to select the ingress path otherwise the egress path is selected. This i=
s the
> +only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +socket entries of type ``struct sock *`` can be retrieved using the
> +``bpf_map_lookup_elem()`` helper.
> +
> +bpf_sock_map_update()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sock_map_update(struct bpf_sock_ops *skops, struct bpf_map =
*map, void *key, u64 flags)
> +
> +Add an entry to, or update a ``map`` referencing sockets. The ``skops`` =
is used
> +as a new value for the entry associated to ``key``. The ``flags`` argume=
nt can
> +be one of the following:
> +
> +- ``BPF_ANY``: Create a new element or update an existing element.
> +- ``BPF_NOEXIST``: Create a new element only if it did not exist.
> +- ``BPF_EXIST``: Update an existing element.
> +
> +If the ``map`` has BPF programs (parser and verdict), those will be inhe=
rited
> +by the socket being added. If the socket is already attached to BPF prog=
rams,
> +this results in an error.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_sock_hash_update()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sock_hash_update(struct bpf_sock_ops *skops, struct bpf_map=
 *map, void *key, u64 flags)
> +
> +Add an entry to, or update a sockhash ``map`` referencing sockets. The `=
`skops``
> +is used as a new value for the entry associated to ``key``.
> +
> +The ``flags`` argument can be one of the following:
> +
> +- ``BPF_ANY``: Create a new element or update an existing element.
> +- ``BPF_NOEXIST``: Create a new element only if it did not exist.
> +- ``BPF_EXIST``: Update an existing element.
> +
> +If the ``map`` has BPF programs (parser and verdict), those will be inhe=
rited
> +by the socket being added. If the socket is already attached to BPF prog=
rams,
> +this results in an error.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_msg_redirect_hash()
> +^^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_redirect_hash(struct sk_msg_buff *msg, struct bpf_map *=
map, void *key, u64 flags)
> +
> +This helper is used in programs implementing policies at the socket leve=
l. If
> +the message ``msg`` is allowed to pass (i.e. if the verdict BPF program =
returns
> +``SK_PASS``), redirect it to the socket referenced by ``map`` (of type
> +``BPF_MAP_TYPE_SOCKHASH``) using hash ``key``. Both ingress and egress
> +interfaces can be used for redirection. The ``BPF_F_INGRESS`` value in
> +``flags`` is used to select the ingress path otherwise the egress path is
> +selected. This is the only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_sk_redirect_hash()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sk_redirect_hash(struct sk_buff *skb, struct bpf_map *map, =
void *key, u64 flags)
> +
> +This helper is used in programs implementing policies at the skb socket =
level.
> +If the sk_buff ``skb`` is allowed to pass (i.e. if the verdict BPF progr=
am
> +returns ``SK_PASS``), redirect it to the socket referenced by ``map`` (o=
f type
> +``BPF_MAP_TYPE_SOCKHASH``) using hash ``key``. Both ingress and egress
> +interfaces can be used for redirection. The ``BPF_F_INGRESS`` value in
> +``flags`` is used to select the ingress path otherwise the egress path is
> +selected. This is the only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_msg_apply_bytes()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)
> +
> +For socket policies, apply the verdict of the BPF program to the next (n=
umber
> +of ``bytes``) of message ``msg``. For example, this helper can be used i=
n the
> +following cases:
> +
> +- A single ``sendmsg()`` or ``sendfile()`` system call contains multiple
> +  logical messages that the BPF program is supposed to read and for whic=
h it
> +  should apply a verdict.
> +- A BPF program only cares to read the first ``bytes`` of a ``msg``. If =
the
> +  message has a large payload, then setting up and calling the BPF progr=
am
> +  repeatedly for all bytes, even though the verdict is already known, wo=
uld
> +  create unnecessary overhead.
> +
> +Returns 0
> +
> +bpf_msg_cork_bytes()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_cork_bytes(struct sk_msg_buff *msg, u32 bytes)
> +
> +For socket policies, prevent the execution of the verdict BPF program for
> +message ``msg`` until the number of ``bytes`` have been accumulated.
> +
> +This can be used when one needs a specific number of bytes before a verd=
ict can
> +be assigned, even if the data spans multiple ``sendmsg()`` or ``sendfile=
()``
> +calls.
> +
> +Returns 0
> +
> +bpf_msg_pull_data()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_pull_data(struct sk_msg_buff *msg, u32 start, u32 end, =
u64 flags)
> +
> +For socket policies, pull in non-linear data from user space for ``msg``=
 and set
> +pointers ``msg->data`` and ``msg->data_end`` to ``start`` and ``end`` by=
tes
> +offsets into ``msg``, respectively.
> +
> +If a program of type ``BPF_PROG_TYPE_SK_MSG`` is run on a ``msg`` it can=
 only
> +parse data that the (``data``, ``data_end``) pointers have already consu=
med.
> +For ``sendmsg()`` hooks this is likely the first scatterlist element. Bu=
t for
> +calls relying on the ``sendpage`` handler (e.g. ``sendfile()``) this wil=
l be
> +the range (**0**, **0**) because the data is shared with user space and =
by
> +default the objective is to avoid allowing user space to modify data whi=
le (or
> +after) BPF verdict is being decided. This helper can be used to pull in =
data
> +and to set the start and end pointer to given values. Data will be copie=
d if
> +necessary (i.e. if data was not linear and if start and end pointers do =
not
> +point to the same chunk).
> +
> +A call to this helper is susceptible to change the underlying packet buf=
fer.
> +Therefore, at load time, all checks on pointers previously done by the v=
erifier
> +are invalidated and must be performed again, if the helper is used in
> +combination with direct packet access.
> +
> +All values for ``flags`` are reserved for future usage, and must be left=
 at
> +zero.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +.. code-block:: c
> +
> +	void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Lookup a socket entry in the sockmap or sockhash map.
> +
> +Returns the socket entry associated to ``key``, or NULL if no entry was =
found.
> +
> +bpf_map_update_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +	long bpf_map_update_elem(struct bpf_map *map, const void *key, const vo=
id *value, u64 flags)
> +
> +Add or update a socket entry in a sockmap or sockhash.
> +
> +The flags argument can be one of the following:
> +
> +- BPF_ANY: Create a new element or update an existing element.
> +- BPF_NOEXIST: Create a new element only if it did not exist.
> +- BPF_EXIST: Update an existing element.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_map_delete_elem()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> +Delete a socket entry from a sockmap or a sockhash.
> +
> +Returns	0 on success, or a negative error in case of failure.
> +
> +User space
> +----------
> +bpf_map_update_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +	int bpf_map_update_elem(int fd, const void *key, const void *value, __u=
64 flags)
> +
> +Sockmap entries can be added or updated using the ``bpf_map_update_elem(=
)``
> +function. The ``key`` parameter is the index value of the sockmap array.=
 And the
> +``value`` parameter is the FD value of that socket.
> +
> +Under the hood, the sockmap update function uses the socket FD value to
> +retrieve the associated socket and its attached psock.
> +
> +The flags argument can be one of the following:
> +
> +- BPF_ANY: Create a new element or update an existing element.
> +- BPF_NOEXIST: Create a new element only if it did not exist.
> +- BPF_EXIST: Update an existing element.
> +
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    int bpf_map_lookup_elem(int fd, const void *key, void *value)
> +
> +Sockmap entries can be retrieved using the ``bpf_map_lookup_elem()`` fun=
ction.
> +
> +.. note::
> +	The entry returned is a socket cookie rather than a socket itself.
> +
> +bpf_map_delete_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    int bpf_map_delete_elem(int fd, const void *key)
> +
> +Sockmap entries can be deleted using the ``bpf_map_delete_elem()``
> +function.
> +
> +Returns 0 on success, or negative error in case of failure.
> +
> +Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kernel BPF
> +----------
> +Several examples of the use of sockmap APIs can be found in:
> +
> +- `tools/testing/selftests/bpf/progs/test_sockmap_kern.h`_
> +- `tools/testing/selftests/bpf/progs/sockmap_parse_prog.c`_
> +- `tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c`_
> +- `tools/testing/selftests/bpf/progs/test_sockmap_listen.c`_
> +- `tools/testing/selftests/bpf/progs/test_sockmap_update.c`_
> +
> +The following code snippet shows how to declare a sockmap.
> +
> +.. code-block:: c
> +
> +	struct {
> +		__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +		__uint(max_entries, 1);
> +		__type(key, __u32);
> +		__type(value, __u64);
> +	} sock_map_rx SEC(".maps");
> +
> +The following code snippet shows a sample parser program.
> +
> +.. code-block:: c
> +
> +	SEC("sk_skb/stream_parser")
> +	int bpf_prog_parser(struct __sk_buff *skb)
> +	{
> +		return skb->len;
> +	}
> +
> +The following code snippet shows a simple verdict program that interacts=
 with a
> +sockmap to redirect traffic to another socket based on the local port.
> +
> +.. code-block:: c
> +
> +	SEC("sk_skb/stream_verdict")
> +	int bpf_prog_verdict(struct __sk_buff *skb)
> +	{
> +		__u32 lport =3D skb->local_port;
> +		__u32 idx =3D 0;
> +
> +		if (lport =3D=3D 10000)
> +			return bpf_sk_redirect_map(skb, &sock_map_rx, idx, 0);
> +
> +		return SK_PASS;
> +	}
> +
> +The following code snippet shows how to declare a sockhash map.
> +
> +.. code-block:: c
> +
> +	struct socket_key {
> +		__u32 src_ip;
> +		__u32 dst_ip;
> +		__u32 src_port;
> +		__u32 dst_port;
> +	};
> +
> +	struct {
> +		__uint(type, BPF_MAP_TYPE_SOCKHASH);
> +		__uint(max_entries, 1);
> +		__type(key, struct socket_key);
> +		__type(value, __u64);
> +	} sock_hash_rx SEC(".maps");
> +
> +The following code snippet shows a simple verdict program that interacts=
 with a
> +sockhash to redirect traffic to another socket based on a hash of some o=
f the
> +skb parameters.
> +
> +.. code-block:: c
> +
> +	static inline
> +	void extract_socket_key(struct __sk_buff *skb, struct socket_key *key)
> +	{
> +		key->src_ip =3D skb->remote_ip4;
> +		key->dst_ip =3D skb->local_ip4;
> +		key->src_port =3D skb->remote_port >> 16;
> +		key->dst_port =3D (bpf_htonl(skb->local_port)) >> 16;
> +	}
> +
> +	SEC("sk_skb/stream_verdict")
> +	int bpf_prog_verdict(struct __sk_buff *skb)
> +	{
> +		struct socket_key key;
> +
> +		extract_socket_key(skb, &key);
> +
> +		return bpf_sk_redirect_hash(skb, &sock_hash_rx, &key, 0);
> +	}
> +
> +User space
> +----------
> +Several examples of the use of sockmap APIs can be found in:
> +
> +- `tools/testing/selftests/bpf/prog_tests/sockmap_basic.c`_
> +- `tools/testing/selftests/bpf/test_sockmap.c`_
> +- `tools/testing/selftests/bpf/test_maps.c`_
> +
> +The following code sample shows how to create a sockmap, attach a parser=
 and
> +verdict program, as well as add a socket entry.
> +
> +.. code-block:: c
> +
> +	int create_sample_sockmap(int sock, int parse_prog_fd, int verdict_prog=
_fd)
> +	{
> +		int index =3D 0;
> +		int map, err;
> +
> +		map =3D bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int), sizeof=
(int), 1, NULL);
> +		if (map < 0) {
> +			fprintf(stderr, "Failed to create sockmap: %s\n", strerror(errno));
> +			return -1;
> +		}
> +
> +		err =3D bpf_prog_attach(parse_prog_fd, map, BPF_SK_SKB_STREAM_PARSER, =
0);
> +		if (err){
> +			fprintf(stderr, "Failed to attach_parser_prog_to_map: %s\n", strerror=
(errno));
> +			goto out;
> +		}
> +
> +		err =3D bpf_prog_attach(verdict_prog_fd, map, BPF_SK_SKB_STREAM_VERDIC=
T, 0);
> +		if (err){
> +			fprintf(stderr, "Failed to attach_verdict_prog_to_map: %s\n", strerro=
r(errno));
> +			goto out;
> +		}
> +
> +		err =3D bpf_map_update_elem(map, &index, &sock, BPF_NOEXIST);
> +		if (err) {
> +			fprintf(stderr, "Failed to update sockmap: %s\n", strerror(errno));
> +			goto out;
> +		}
> +
> +	out:
> +		close(map);
> +		return err;
> +	}
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- https://github.com/jrfastab/linux-kernel-xdp/commit/c89fd73cb9d2d7f3c7=
16c3e00836f07b1aeb261f
> +- https://lwn.net/Articles/731133/
> +- http://vger.kernel.org/lpc_net2018_talks/ktls_bpf_paper.pdf
> +- https://lwn.net/Articles/748628/
> +
> +.. _`tools/testing/selftests/bpf/progs/test_sockmap_kern.h`: https://git=
=2Ekernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testin=
g/selftests/bpf/progs/test_sockmap_kern.h
> +.. _`tools/testing/selftests/bpf/progs/sockmap_parse_prog.c`: https://gi=
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing=
/selftests/bpf/progs/sockmap_parse_prog.c
> +.. _`tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c`: https://=
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testi=
ng/selftests/bpf/progs/sockmap_verdict_prog.c
> +.. _`tools/testing/selftests/bpf/prog_tests/sockmap_basic.c`: https://gi=
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing=
/selftests/bpf/prog_tests/sockmap_basic.c
> +.. _`tools/testing/selftests/bpf/test_sockmap.c`: https://git.kernel.org=
/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/b=
pf/test_sockmap.c
> +.. _`tools/testing/selftests/bpf/test_maps.c`: https://git.kernel.org/pu=
b/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/=
test_maps.c
> +.. _`tools/testing/selftests/bpf/progs/test_sockmap_listen.c`: https://g=
it.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testin=
g/selftests/bpf/progs/test_sockmap_listen.c
> +.. _`tools/testing/selftests/bpf/progs/test_sockmap_update.c`: https://g=
it.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testin=
g/selftests/bpf/progs/test_sockmap_update.c

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--oLkXBWWwsr/wfmcK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5BfpwAKCRD2uYlJVVFO
o/eMAPwJH+0ShyXCCs5mEveew7PGxAhwx6ZqYvocfYLVO3zzegEAuMi6B0lahlxG
oNYvsey9oRw9aXnradFRYZ84G/FANQs=
=6GCI
-----END PGP SIGNATURE-----

--oLkXBWWwsr/wfmcK--
