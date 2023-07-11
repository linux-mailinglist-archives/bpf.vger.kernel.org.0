Return-Path: <bpf+bounces-4796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3374F820
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3953B2813BC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF41DDE6;
	Tue, 11 Jul 2023 18:49:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF94171D9;
	Tue, 11 Jul 2023 18:49:01 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E641BB;
	Tue, 11 Jul 2023 11:48:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e46e83d7fso5168448a12.1;
        Tue, 11 Jul 2023 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689101337; x=1691693337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMEz/nQIDscrHuz7YiPkXLNCkJ+csDlqhx+U95I53sA=;
        b=jHDAHkmWDXCFRFPyYyXwOaArH8V/NOXmhF5C5JZOJV8R8sYjnlPuHsiqI9h179ftW5
         ceGaVom3uOdDjUQugmc1X9Bo4py/C1aZqdPSnboQ4TN+B/6udwxEjeiFG/ckvPMml/Ts
         R5ap0ITei8RbxHV79+UQG/7NaQpM38sToQ+sCYjWMfXV/ak1jnI/W2YoAx27Xsv4kcXG
         w+OKVd0XRpNDlg6fDxBUP4PG4s22n2K54QkQfsG3BA71zzA/U06hZcC6Ztd0QzG0O384
         tmj26hFKAIRxEVVg5YF4EcnqSjrY5r3yUZO9a4Ba1QDD//xbjrYNyrog+lX19ogVVrM1
         G41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689101337; x=1691693337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMEz/nQIDscrHuz7YiPkXLNCkJ+csDlqhx+U95I53sA=;
        b=KX+v9/C13BSUXdbtlitXkPaiArQ3s2w1rwtv7CD11dGBuSwVSi+gzYSNyxKgsmOxKQ
         TtD2GlTRm6liEqmCtMN+sZ1lsUrrw+0nJ6T2zIKhlOmyI+nAh1qBZxLRdg5uJNwy5yPW
         OdoLlDM2l/HOoCxXOcjd2axzXD0h2zMtN41upwSRdLN6NIVK6eY7QRBJL+pH6Kg5A5+V
         6cME60W/czlrICZA6e63T+MIMz3AsfIB8V0oAQpA4rz1+dt6cbtATse0YcBkbBaoAvxK
         RqCbGynH7R94rBUILgG7cNzQfRXy9wNmGxQ0BHvMtVZsFGlaXTHM2roqaieskYzhR9t0
         oceQ==
X-Gm-Message-State: ABy/qLajlcLa/daNr9HAsCQ2nXgsgflNMH/XTavv8BmxWFkZMN/y9ieI
	vYKTOM61gaHmHFc7TYEIoQfI35t1wffd0fpEWNQ=
X-Google-Smtp-Source: APBJJlFwbGt1vJAqw0YIw0Xh6HAYwBynHAaSMGn0sQlpepaQrkw5jX+JswQ+dEaT9ZGC8+DNBrKAyaL20Y2qiW84jwc=
X-Received: by 2002:a50:e610:0:b0:51d:d30c:f1e3 with SMTP id
 y16-20020a50e610000000b0051dd30cf1e3mr15442950edm.16.1689101336931; Tue, 11
 Jul 2023 11:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710201218.19460-1-daniel@iogearbox.net> <20230710201218.19460-2-daniel@iogearbox.net>
In-Reply-To: <20230710201218.19460-2-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 11:48:44 -0700
Message-ID: <CAEf4Bza_X30yLPm0Lhy2c-u1Qw1Ci9AVoy5jo_XXCaT9zz+3jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, 
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 1:12=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> This adds a generic layer called bpf_mprog which can be reused by differe=
nt
> attachment layers to enable multi-program attachment and dependency resol=
ution.
> In-kernel users of the bpf_mprog don't need to care about the dependency
> resolution internals, they can just consume it with few API calls.
>
> The initial idea of having a generic API sparked out of discussion [0] fr=
om an
> earlier revision of this work where tc's priority was reused and exposed =
via
> BPF uapi as a way to coordinate dependencies among tc BPF programs, simil=
ar
> as-is for classic tc BPF. The feedback was that priority provides a bad u=
ser
> experience and is hard to use [1], e.g.:
>
>   I cannot help but feel that priority logic copy-paste from old tc, netf=
ilter
>   and friends is done because "that's how things were done in the past". =
[...]
>   Priority gets exposed everywhere in uapi all the way to bpftool when it=
's
>   right there for users to understand. And that's the main problem with i=
t.
>
>   The user don't want to and don't need to be aware of it, but uapi force=
s them
>   to pick the priority. [...] Your cover letter [0] example proves that i=
n
>   real life different service pick the same priority. They simply don't k=
now
>   any better. Priority is an unnecessary magic that apps _have_ to pick, =
so
>   they just copy-paste and everyone ends up using the same.
>
> The course of the discussion showed more and more the need for a generic,
> reusable API where the "same look and feel" can be applied for various ot=
her
> program types beyond just tc BPF, for example XDP today does not have mul=
ti-
> program support in kernel, but also there was interest around this API fo=
r
> improving management of cgroup program types. Such common multi-program
> management concept is useful for BPF management daemons or user space BPF
> applications coordinating internally about their attachments.
>
> Both from Cilium and Meta side [2], we've collected the following require=
ments
> for a generic attach/detach/query API for multi-progs which has been impl=
emented
> as part of this work:
>
>   - Support prog-based attach/detach and link API
>   - Dependency directives (can also be combined):
>     - BPF_F_{BEFORE,AFTER} with relative_{fd,id} which can be {prog,link,=
none}
>       - BPF_F_ID flag as {fd,id} toggle; the rationale for id is so that =
user
>         space application does not need CAP_SYS_ADMIN to retrieve foreign=
 fds
>         via bpf_*_get_fd_by_id()
>       - BPF_F_LINK flag as {prog,link} toggle
>       - If relative_{fd,id} is none, then BPF_F_BEFORE will just prepend,=
 and
>         BPF_F_AFTER will just append for attaching
>       - Enforced only at attach time
>     - BPF_F_REPLACE with replace_bpf_fd which can be prog, links have the=
ir
>       own infra for replacing their internal prog
>     - If no flags are set, then it's default append behavior for attachin=
g
>   - Internal revision counter and optionally being able to pass expected_=
revision
>   - User space application can query current state with revision, and pas=
s it
>     along for attachment to assert current state before doing updates
>   - Query also gets extension for link_ids array and link_attach_flags:
>     - prog_ids are always filled with program IDs
>     - link_ids are filled with link IDs when link was used, otherwise 0
>     - {prog,link}_attach_flags for holding {prog,link}-specific flags
>   - Must be easy to integrate/reuse for in-kernel users
>
> The uapi-side changes needed for supporting bpf_mprog are rather minimal,
> consisting of the additions of the attachment flags, revision counter, an=
d
> expanding existing union with relative_{fd,id} member.
>
> The bpf_mprog framework consists of an bpf_mprog_entry object which holds
> an array of bpf_mprog_fp (fast-path structure). The bpf_mprog_cp (control=
-path
> structure) is part of bpf_mprog_bundle. Both have been separated, so that
> fast-path gets efficient packing of bpf_prog pointers for maximum cache
> efficiency. Also, array has been chosen instead of linked list or other
> structures to remove unnecessary indirections for a fast point-to-entry i=
n
> tc for BPF.
>
> The bpf_mprog_entry comes as a pair via bpf_mprog_bundle so that in case =
of
> updates the peer bpf_mprog_entry is populated and then just swapped which
> avoids additional allocations that could otherwise fail, for example, in
> detach case. bpf_mprog_{fp,cp} arrays are currently static, but they coul=
d
> be converted to dynamic allocation if necessary at a point in future.
> Locking is deferred to the in-kernel user of bpf_mprog, for example, in c=
ase
> of tcx which uses this API in the next patch, it piggybacks on rtnl.
>
> An extensive test suite for checking all aspects of this API for prog-bas=
ed
> attach/detach and link API comes as BPF selftests in this series.
>
> Kudos also to Andrii Nakryiko for API discussions wrt Meta's BPF manageme=
nt.
>
>   [0] https://lore.kernel.org/bpf/20221004231143.19190-1-daniel@iogearbox=
.net
>   [1] https://lore.kernel.org/bpf/CAADnVQ+gEY3FjCR=3D+DmjDR4gp5bOYZUFJQXj=
4agKFHT9CQPZBw@mail.gmail.com
>   [2] http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkman=
n.pdf
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  MAINTAINERS                    |   1 +
>  include/linux/bpf_mprog.h      | 343 ++++++++++++++++++++++++++
>  include/uapi/linux/bpf.h       |  36 ++-
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/mprog.c             | 427 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  36 ++-
>  6 files changed, 828 insertions(+), 17 deletions(-)
>  create mode 100644 include/linux/bpf_mprog.h
>  create mode 100644 kernel/bpf/mprog.c
>

From UAPI perspective looks great! Few implementation suggestion
below. I'll also reply separately to Alexei's reply with discussion on
higher-level *internal* API.

[...]

> +
> +#define BPF_MPROG_KEEP 0
> +#define BPF_MPROG_SWAP 1
> +#define BPF_MPROG_FREE 2
> +
> +#define BPF_MPROG_MAX  64
> +
> +#define bpf_mprog_foreach_tuple(entry, fp, cp, t)                      \
> +       for (fp =3D &entry->fp_items[0], cp =3D &entry->parent->cp_items[=
0];\
> +            ({                                                         \
> +               t.prog =3D READ_ONCE(fp->prog);                          =
 \
> +               t.link =3D cp->link;                                     =
 \
> +               t.prog;                                                 \
> +             });                                                       \
> +            fp++, cp++)

I wish we could do something like the below to avoid the need to pass
fp and cp from outside:

for (struct { struct bpf_mprog_fp *fp; struct bpf_mprog_cp *cp;} tmp =3D
     { &entry->fp_items[0], &entry->parent->cp_iterms[0]};
     t.link =3D tmp.cp->link, t.prog =3D READ_ONCE(tmp.fp->prog);
     fp++, cp++)

But I'm not sure the kernel's C style allows that yet.

But I think you can use the comma operator to avoid that more verbose
({ }) construct.

> +
> +#define bpf_mprog_foreach_prog(entry, fp, p)                           \
> +       for (fp =3D &entry->fp_items[0];                                 =
 \
> +            (p =3D READ_ONCE(fp->prog));                                =
 \
> +            fp++)
> +

[...]

> +static inline void bpf_mprog_inc(struct bpf_mprog_entry *entry)
> +{
> +       entry->parent->count++;
> +}
> +
> +static inline void bpf_mprog_dec(struct bpf_mprog_entry *entry)
> +{
> +       entry->parent->count--;
> +}
> +
> +static inline int bpf_mprog_max(void)
> +{
> +       return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_items) - 1=
;
> +}

so we can only add BPF_MPROG_MAX - 1 progs, right? I presume the last
entry is presumed to be always NULL, right?

> +
> +static inline int bpf_mprog_total(struct bpf_mprog_entry *entry)
> +{
> +       int total =3D entry->parent->count;
> +
> +       WARN_ON_ONCE(total > bpf_mprog_max());
> +       return total;
> +}
> +

[...]

> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 1d3892168d32..1bea2eb912cd 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o per=
cpu_freelist.o bpf_lru_list
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_local_storage.o bpf_task_storage.o
>  obj-${CONFIG_BPF_LSM}    +=3D bpf_inode_storage.o
> -obj-$(CONFIG_BPF_SYSCALL) +=3D disasm.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D disasm.o mprog.o
>  obj-$(CONFIG_BPF_JIT) +=3D trampoline.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf.o memalloc.o
>  obj-$(CONFIG_BPF_JIT) +=3D dispatcher.o
> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> new file mode 100644
> index 000000000000..1c4fcde74969
> --- /dev/null
> +++ b/kernel/bpf/mprog.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Isovalent */
> +
> +#include <linux/bpf.h>
> +#include <linux/bpf_mprog.h>
> +
> +static int bpf_mprog_link(struct bpf_tuple *tuple,
> +                         u32 object, u32 flags,

so I tried to get used to this "object" notation, but I think it's
still awkwards and keeps me asking "what is this really" every single
time I read this. I wonder if something like "fd_or_id" as a name
would make it more obvious?

> +                         enum bpf_prog_type type)
> +{
> +       bool id =3D flags & BPF_F_ID;
> +       struct bpf_link *link;
> +

should we reject this object/fd_or_id if it's zero, instead of trying
to lookup ID/FD 0?


> +       if (id)
> +               link =3D bpf_link_by_id(object);
> +       else
> +               link =3D bpf_link_get_from_fd(object);
> +       if (IS_ERR(link))
> +               return PTR_ERR(link);
> +       if (type && link->prog->type !=3D type) {
> +               bpf_link_put(link);
> +               return -EINVAL;
> +       }
> +
> +       tuple->link =3D link;
> +       tuple->prog =3D link->prog;
> +       return 0;
> +}
> +
> +static int bpf_mprog_prog(struct bpf_tuple *tuple,
> +                         u32 object, u32 flags,
> +                         enum bpf_prog_type type)
> +{
> +       bool id =3D flags & BPF_F_ID;
> +       struct bpf_prog *prog;
> +

same here about rejecting zero object?

> +       if (id)
> +               prog =3D bpf_prog_by_id(object);
> +       else
> +               prog =3D bpf_prog_get(object);
> +       if (IS_ERR(prog)) {
> +               if (!object && !id)
> +                       return 0;
> +               return PTR_ERR(prog);
> +       }
> +       if (type && prog->type !=3D type) {
> +               bpf_prog_put(prog);
> +               return -EINVAL;
> +       }
> +
> +       tuple->link =3D NULL;
> +       tuple->prog =3D prog;
> +       return 0;
> +}
> +
> +static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
> +                                   u32 object, u32 flags,
> +                                   enum bpf_prog_type type)
> +{
> +       memset(tuple, 0, sizeof(*tuple));
> +       if (flags & BPF_F_LINK)
> +               return bpf_mprog_link(tuple, object, flags, type);
> +       return bpf_mprog_prog(tuple, object, flags, type);
> +}
> +
> +static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
> +{
> +       if (tuple->link)
> +               bpf_link_put(tuple->link);
> +       else if (tuple->prog)
> +               bpf_prog_put(tuple->prog);
> +}
> +
> +static int bpf_mprog_replace(struct bpf_mprog_entry *entry,
> +                            struct bpf_tuple *ntuple, int idx)
> +{
> +       struct bpf_mprog_fp *fp;
> +       struct bpf_mprog_cp *cp;
> +       struct bpf_prog *oprog;
> +
> +       bpf_mprog_read(entry, idx, &fp, &cp);
> +       oprog =3D READ_ONCE(fp->prog);
> +       bpf_mprog_write(fp, cp, ntuple);
> +       if (!ntuple->link) {
> +               WARN_ON_ONCE(cp->link);
> +               bpf_prog_put(oprog);
> +       }
> +       return BPF_MPROG_KEEP;
> +}
> +
> +static int bpf_mprog_insert(struct bpf_mprog_entry *entry,
> +                           struct bpf_tuple *ntuple, int idx, u32 flags)
> +{
> +       int i, j =3D 0, total =3D bpf_mprog_total(entry);
> +       struct bpf_mprog_cp *cp, cpp[BPF_MPROG_MAX] =3D {};

a bit worried about using 512 bytes for local cpp array... my initial
assumption was that we won't have to create a copy of cp_iterms, just
update it in place. Hm... let's have the higher-level API discussion
in one branch, where Alexei has some proposals as well.

> +       struct bpf_mprog_fp *fp, *fpp;
> +       struct bpf_mprog_entry *peer;
> +
> +       peer =3D bpf_mprog_peer(entry);
> +       bpf_mprog_entry_clear(peer);
> +       if (idx < 0) {
> +               bpf_mprog_read_fp(peer, j, &fpp);
> +               bpf_mprog_write_fp(fpp, ntuple);
> +               bpf_mprog_write_cp(&cpp[j], ntuple);
> +               j++;
> +       }
> +       for (i =3D 0; i <=3D total; i++) {
> +               bpf_mprog_read_fp(peer, j, &fpp);
> +               if (idx =3D=3D i && (flags & BPF_F_AFTER)) {
> +                       bpf_mprog_write(fpp, &cpp[j], ntuple);
> +                       j++;
> +                       bpf_mprog_read_fp(peer, j, &fpp);
> +               }
> +               if (i < total) {
> +                       bpf_mprog_read(entry, i, &fp, &cp);
> +                       bpf_mprog_copy(fpp, &cpp[j], fp, cp);
> +                       j++;
> +               }
> +               if (idx =3D=3D i && (flags & BPF_F_BEFORE)) {
> +                       bpf_mprog_read_fp(peer, j, &fpp);
> +                       bpf_mprog_write(fpp, &cpp[j], ntuple);
> +                       j++;
> +               }
> +       }

sorry if I miss some subtle point, but I wonder why this is so
complicated? I think this choice of idx =3D=3D -1 meaning prepend is
leading to this complication. It's not also clear why there is this
BPF_F_AFTER vs BPF_F_BEFORE distinction when we already determined a
position where new program has to be inserted (so after or before
should be irrelevant).

Please let me know why the below doesn't work.

Let's define that idx is the position where new prog/link tuple has to
be inserted. It can be in the range [0, N], where N is number of
programs currently in the mprog_peer. Note that N is inclusive above.

The algorithm for insertion is simple: everything currently at
entry->fp_items[idx] and after gets shifted. And we can do it with a
simple memmove:

memmove(peer->fp_items + idx + 1, peer->fp_iters + idx,
(bpf_mprog_total(entry) - idx) * sizeof(struct bpf_mprof_fp));
/* similar memmove for cp_items/cpp array, of course */
/* now set new prog at peer->fp_items[idx] */

The above should replace entire above for loop and that extra if
before the loop. And it should work for corner cases:

  - idx =3D=3D 0 (prepend), will shift everything to the right, and put
new prog at position 0. Exactly what we wanted.
  - idx =3D=3D N (append), will shift nothing (that memmov should be a
no-op because size is zero, total =3D=3D idx =3D=3D N)


We just need to make sure that the above shift won't overwrite the
very last NULL. So bpf_mprog_total() should be < BPF_MPROG_MAX - 2
before all this.

Seems as simple as that, is there any complication I skimmed over?


> +       bpf_mprog_commit_cp(peer, cpp);
> +       bpf_mprog_inc(peer);
> +       return BPF_MPROG_SWAP;
> +}
> +
> +static int bpf_mprog_tuple_confirm(struct bpf_mprog_entry *entry,
> +                                  struct bpf_tuple *dtuple, int idx)
> +{
> +       int first =3D 0, last =3D bpf_mprog_total(entry) - 1;
> +       struct bpf_mprog_cp *cp;
> +       struct bpf_mprog_fp *fp;
> +       struct bpf_prog *prog;
> +       struct bpf_link *link;
> +
> +       if (idx <=3D first)
> +               bpf_mprog_read(entry, first, &fp, &cp);
> +       else if (idx >=3D last)
> +               bpf_mprog_read(entry, last, &fp, &cp);
> +       else
> +               bpf_mprog_read(entry, idx, &fp, &cp);
> +
> +       prog =3D READ_ONCE(fp->prog);
> +       link =3D cp->link;
> +       if (!dtuple->link && link)
> +               return -EBUSY;
> +
> +       WARN_ON_ONCE(dtuple->prog && dtuple->prog !=3D prog);
> +       WARN_ON_ONCE(dtuple->link && dtuple->link !=3D link);
> +
> +       dtuple->prog =3D prog;
> +       dtuple->link =3D link;
> +       return 0;
> +}
> +
> +static int bpf_mprog_delete(struct bpf_mprog_entry *entry,
> +                           struct bpf_tuple *dtuple, int idx)
> +{
> +       int i =3D 0, j, ret, total =3D bpf_mprog_total(entry);
> +       struct bpf_mprog_cp *cp, cpp[BPF_MPROG_MAX] =3D {};
> +       struct bpf_mprog_fp *fp, *fpp;
> +       struct bpf_mprog_entry *peer;
> +
> +       ret =3D bpf_mprog_tuple_confirm(entry, dtuple, idx);
> +       if (ret)
> +               return ret;
> +       peer =3D bpf_mprog_peer(entry);
> +       bpf_mprog_entry_clear(peer);
> +       if (idx < 0)
> +               i++;
> +       if (idx =3D=3D total)
> +               total--;
> +       for (j =3D 0; i < total; i++) {
> +               if (idx =3D=3D i)
> +                       continue;
> +               bpf_mprog_read_fp(peer, j, &fpp);
> +               bpf_mprog_read(entry, i, &fp, &cp);
> +               bpf_mprog_copy(fpp, &cpp[j], fp, cp);
> +               j++;
> +       }
> +       bpf_mprog_commit_cp(peer, cpp);
> +       bpf_mprog_dec(peer);
> +       bpf_mprog_mark_ref(peer, dtuple);
> +       return bpf_mprog_total(peer) ?
> +              BPF_MPROG_SWAP : BPF_MPROG_FREE;

for delete it's also a bit unclear to me. We are deleting some
specific spot, so idx should be a valid [0, N) value, no? Then why the
bpf_mprog_tuple_confirm() has this special <=3D first and idx >=3D last
handling?

Deletion should be similar to instertion, just the shift is in the
other direction. And then setting NULLs at N-1 position to ensure
proper NULL termination of fp array.

> +}
> +
> +/* In bpf_mprog_pos_*() we evaluate the target position for the BPF
> + * program/link that needs to be replaced, inserted or deleted for
> + * each "rule" independently. If all rules agree on that position
> + * or existing element, then enact replacement, addition or deletion.
> + * If this is not the case, then the request cannot be satisfied and
> + * we bail out with an error.
> + */
> +static int bpf_mprog_pos_exact(struct bpf_mprog_entry *entry,
> +                              struct bpf_tuple *tuple)
> +{
> +       struct bpf_mprog_fp *fp;
> +       struct bpf_mprog_cp *cp;
> +       int i;
> +
> +       for (i =3D 0; i < bpf_mprog_total(entry); i++) {
> +               bpf_mprog_read(entry, i, &fp, &cp);
> +               if (tuple->prog =3D=3D READ_ONCE(fp->prog))
> +                       return tuple->link =3D=3D cp->link ? i : -EBUSY;
> +       }
> +       return -ENOENT;
> +}
> +
> +static int bpf_mprog_pos_before(struct bpf_mprog_entry *entry,
> +                               struct bpf_tuple *tuple)
> +{
> +       struct bpf_mprog_fp *fp;
> +       struct bpf_mprog_cp *cp;
> +       int i;
> +
> +       for (i =3D 0; i < bpf_mprog_total(entry); i++) {
> +               bpf_mprog_read(entry, i, &fp, &cp);
> +               if (tuple->prog =3D=3D READ_ONCE(fp->prog) &&
> +                   (!tuple->link || tuple->link =3D=3D cp->link))
> +                       return i - 1;

taking all the above into account, this should just `return i;`

> +       }
> +       return tuple->prog ? -ENOENT : -1;
> +}
> +
> +static int bpf_mprog_pos_after(struct bpf_mprog_entry *entry,
> +                              struct bpf_tuple *tuple)
> +{
> +       struct bpf_mprog_fp *fp;
> +       struct bpf_mprog_cp *cp;
> +       int i;
> +
> +       for (i =3D 0; i < bpf_mprog_total(entry); i++) {
> +               bpf_mprog_read(entry, i, &fp, &cp);
> +               if (tuple->prog =3D=3D READ_ONCE(fp->prog) &&
> +                   (!tuple->link || tuple->link =3D=3D cp->link))
> +                       return i + 1;
> +       }
> +       return tuple->prog ? -ENOENT : bpf_mprog_total(entry);
> +}

I actually wonder if it would be simpler to not have _exact, _before,
and _after variant. Instead do generic find of a tuple. And then
outside of that, depending on BPF_F_BEFORE/BPF_F_AFTER/BPF_F_REPLACE
just adjust returned position (if item is found) to either keep it as
is for BPF_F_BEFORE and BPF_F_REPLACE, or adjust it +1 for BPF_F_AFTER

> +
> +int bpf_mprog_attach(struct bpf_mprog_entry *entry, struct bpf_prog *pro=
g_new,
> +                    struct bpf_link *link, struct bpf_prog *prog_old,
> +                    u32 flags, u32 object, u64 revision)
> +{
> +       struct bpf_tuple rtuple, ntuple =3D {
> +               .prog =3D prog_new,
> +               .link =3D link,
> +       }, otuple =3D {
> +               .prog =3D prog_old,
> +               .link =3D link,
> +       };
> +       int ret, idx =3D -2, tidx;

so here I'd init idx to some "impossible" error, like -ERANGE (to pair
with -EDOM ;)

> +
> +       if (revision && revision !=3D bpf_mprog_revision(entry))
> +               return -ESTALE;
> +       if (bpf_mprog_exists(entry, prog_new))
> +               return -EEXIST;
> +       ret =3D bpf_mprog_tuple_relative(&rtuple, object,
> +                                      flags & ~BPF_F_REPLACE,
> +                                      prog_new->type);
> +       if (ret)
> +               return ret;
> +       if (flags & BPF_F_REPLACE) {
> +               tidx =3D bpf_mprog_pos_exact(entry, &otuple);
> +               if (tidx < 0) {
> +                       ret =3D tidx;
> +                       goto out;
> +               }
> +               idx =3D tidx;
> +       }
> +       if (flags & BPF_F_BEFORE) {
> +               tidx =3D bpf_mprog_pos_before(entry, &rtuple);
> +               if (tidx < -1 || (idx >=3D -1 && tidx !=3D idx)) {
> +                       ret =3D tidx < -1 ? tidx : -EDOM;
> +                       goto out;
> +               }
> +               idx =3D tidx;
> +       }
> +       if (flags & BPF_F_AFTER) {
> +               tidx =3D bpf_mprog_pos_after(entry, &rtuple);
> +               if (tidx < -1 || (idx >=3D -1 && tidx !=3D idx)) {
> +                       ret =3D tidx < 0 ? tidx : -EDOM;
> +                       goto out;
> +               }
> +               idx =3D tidx;

and then here just have special casing for -ERANGE, and otherwise
treat anything else negative as error

tidx =3D bpf_mprog_pos_exact(entry, &rtuple);
/* and adjust +1 for BPF_F_AFTER */
if (tidx >=3D 0)
    tidx +=3D 1;
if (idx !=3D -ERANGE && tidx !=3D idx) {
    ret =3D tidx < 0 ? tidx : -EDOM;
    goto out;
}
idx =3D tidx;

> +       }
> +       if (idx < -1) {
> +               if (rtuple.prog || flags) {
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +               idx =3D bpf_mprog_total(entry);
> +               flags =3D BPF_F_AFTER;
> +       }
> +       if (idx >=3D bpf_mprog_max()) {
> +               ret =3D -EDOM;
> +               goto out;
> +       }
> +       if (flags & BPF_F_REPLACE)
> +               ret =3D bpf_mprog_replace(entry, &ntuple, idx);
> +       else
> +               ret =3D bpf_mprog_insert(entry, &ntuple, idx, flags);
> +out:
> +       bpf_mprog_tuple_put(&rtuple);
> +       return ret;
> +}
> +

[...]

