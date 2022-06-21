Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038B4553EEE
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 01:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353804AbiFUXa2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 19:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355181AbiFUXa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 19:30:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8426D3057B
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:30:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id es26so19782226edb.4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:content-transfer-encoding
         :user-agent:mime-version;
        bh=cUvnnAC7JM0Ia+wIWHLm2RdcFZ9+PFMTb91/tb8rPjo=;
        b=ckcCU0KJ5wD8BLkzj5ZC1pndIs+61BNrrgDtII2MU85A1pkd2yoxV04HYPAiOx9hhD
         JLJ4+1Uh/Qcq4ranAyCZoRhbYlrg+wZfpicOLh24YMiw57WX5qxx+vzwSeBUWVMlFUhU
         d8vCsw3GocnaYQ2jg6AHt53z92YmPowJk8V9utYFKzYi06l3VDYzMvsEpQYQghMmDxPy
         DDhCKnMSXT01bW1H0bH53qmMMiDfZ7veUSqyIdId7BlmrgSJsUamOfR41C+QtG0yyxZA
         yGsvPWomqCc9bX8M8B3VhddxNglMgVWkB0O6w6ZhYMVcA/K2yyKfFMitMbTyIG1dJJWo
         RF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date
         :content-transfer-encoding:user-agent:mime-version;
        bh=cUvnnAC7JM0Ia+wIWHLm2RdcFZ9+PFMTb91/tb8rPjo=;
        b=xjnh2wDnrEuGkjZ/O86A0+feF1WH9ZtEJftUHOZr/8S5RlEUMF2+6ng2ZzRoHvlFXg
         U+MdC6Xb7IIxLrfVBFtFJdpA0OmsrIv+J1gWZ1KNWCDYHKJj1f/WJi+ZuMJp5d6meCb7
         WOYWe3X7kgUaGhMhMCgQVNpBEFBDH/HY/eHBmcYoHCU1T21fUeh5atYaaRLOxdrseqHm
         RHUfTd1eqiRuIyKgwOwDLJkxwii36F/Q4MkduvJIQqlUcyCW49tJkczOqD+iOFOx8jNZ
         DzBSRoFn55hQaPRLoK4rMGzbpq7J5/qDdD+97UZEooXAL51ME+6x5tu0hNb9iOqyZuS9
         cTcg==
X-Gm-Message-State: AJIora/0PBuyKNn4kvHVCwzC34Emc4d0Wim6wW30iVtVrA5eNE68jBgU
        8PqhMU95PvazOAYpPMbNZwYbF0mbfNFHoQ==
X-Google-Smtp-Source: AGRyM1tNTGh38jwLZ/EIV66fwQkTsii7uBhQ056gy+mSq+YGJu+W+43BLtqFuosYoyz/oFuR/Vr2Ug==
X-Received: by 2002:a05:6402:528f:b0:42a:c778:469e with SMTP id en15-20020a056402528f00b0042ac778469emr666051edb.404.1655854224662;
        Tue, 21 Jun 2022 16:30:24 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b0042617ba63c2sm14092717edb.76.2022.06.21.16.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 16:30:23 -0700 (PDT)
Message-ID: <43f4de24e5981152b8a31d4629e199c012c4f52c.camel@gmail.com>
Subject: [RFC bpf-next] Speedup for verifier.c:do_misc_fixups
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Date:   Wed, 22 Jun 2022 02:30:21 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Everyone,

Below I describe a scenario when function `verifier.c:do_misc_fixups`
exhibits O(n**2) performance for certain BPF programs. I also describe
a possible adjustment for the `verifier.c:do_misc_fixups` to avoid
such behavior. I can work on this adjustment in my spare time for a
few weeks if the community is interested.

The function `verifier.c:do_misc_fixups` uses
`verifier.c:bpf_patch_insn_data` to replace single instructions with a
series of instructions. The `verifier.c:bpf_patch_insn_data` is a
wrapper for the function `core.c:bpf_patch_insn_single`. The latter
function operates in the following manner:
- allocates new instructions array of size `old size + patch size`;
- copies old instructions;
- copies patch instructions;
- adjusts offset fields for all instructions.

This algorithm means that for pathological BPF programs the
`verifier.c:do_misc_fixups` would demonstrate running time
proportional to the square of the program length.
An example of such program looks as follows:

BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64);
... N times ...
BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64);
BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
BPF_EXIT_INSN();

`verifier.c:do_misc_fixups` replaces each call to jiffies by 3
instructions. Hence the code above would lead to the copying of
(N + N+2 + N+4 ... + N+2N) bytes, which is O(n**2).

Experimental results confirm this observation.  Here is the output of
the demo program:

  prog len     verif time usec
       128          1461
       256 x2       4132 x2.8
       512 x2      12510 x3.0
      1024 x2      44022 x3.5
      2048 x2     170479 x3.9
      4096 x2     646766 x3.8
      8192 x2    2557379 x4.0

The source code for this program is at the end of this email.

The following technique could be used to improve the running time of
the `verifier.c:do_misc_fixups`:
- patches are not applied immediately but are accumulated;
- patches are stored in the intermediate array; the size of this array
  is doubled when the capacity for the new patch is insufficient;
- patches are applied at once at the end of the `verifier.c:do_misc_fixups`=
;
- intermediate data structure is constructed to efficiently map
  between old and new instruction indexes;
- instruction offset fields are updated using this data structure.

In terms of the C code, this could look as follows:

/* Describes a single patch:
 * BPF instruction at index `offset` is replaced by
 * a series of the instructions pointed to by `insns`.
 */
struct bpf_patch {
  int offset;             /* index inside the original program,
                           * the instruction at this index would be replace=
d.
                           */
  int insns_count;        /* size of the patch */
  int delta;              /* difference in indexes between original program=
 and
                           * new program after application of all patches u=
p to
                           * and including this one.
                           */
  struct bpf_insn *insns; /* patch instructions */
};

/* Used to accumulate patches */
struct bpf_patching_state {
  struct bpf_patch *patches; /* array of all patches*/
  int patches_count;         /* current amount of patches */
  int patches_capacity;      /* total capacity of the patches array */
  struct bpf_insn *insns;    /* array of patch instructions,
                              * bpf_patch::insns points to the middle of th=
is array
                              */
  int insns_count;           /* first free index in the instructions array =
*/
  int insns_capacity;        /* total capacity of the instructions array */
};

/* Allocates `patches` and `insns` arrays with some initial capacity */
static int init_patching_state(struct bpf_patching_state *state)
{ ... }

/* Adds a patch record to the `bpf_patching_state::patches` array.
 * If array capacity is insufficient, its size is doubled.
 * Copies `insns` to the end of the `bpf_patching_state::insns`.
 * If array capacity is insufficient, its size is doubled.
 *
 * It is assumed that patches are added in increasing order of
 * the `bpf_patch::offset` field.
 */
static int add_patch(struct bpf_patching_state *state,
                     int offset,
                     int insns_count,
                     struct bpf_insn *insns)
{ ... }

/* - fills in the `bpf_patch::delta` fields for all patches in `state`.
 * - allocates new program
 * - copies program and patch instructions using the `patch_and_copy_insn` =
function
 */
static struct bpf_insn* apply_patches(struct bpf_patching_state *state,
                                      struct bpf_insn *prog,
                                      int *prog_size) {
{
  int delta =3D 0;
  for (int i =3D 0; i < state->patches_count; ++i) {
    delta +=3D state->patches[i].insns_count - 1;
    state->patches[i].delta =3D delta;
  }
  ...
}

/* Uses binary search to find `bpf_patch::delta` corresponding to `index`.
 * `index` stands for the index of instruction in the original program.
 * Looks for the closest `state->patches[?]->offset <=3D index` and returns=
 it's `delta`.
 */
static int lookup_delta_for_index(struct bpf_patching_state *state, int ind=
ex)
{ ... }

/* Copies instruction at `src` to instruction at `dst` and adjusts `dst->of=
f` field.
 * `pc` stands for the instruction index of `src` in the original program.
 */
static void patch_and_copy_insn(struct bpf_patching_state *state,
                                int pc,
                                struct bpf_insn *dst,
                                struct bpf_insn *src)
{
  int new_pc =3D pc + lookup_delta_for_index(state, pc);
  int new_dst =3D pc + dst->off + lookup_delta_for_index(state, pc + dst->o=
ff);

  memcpy(dst, src, sizeof(struct bpf_insn));
  dst->off =3D new_dst - new_pc;
}

Please let me know what you think about this change and whether or not
it should be implemented.

Best regards,
Eduard Zingerman

---
// Demo program
---

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/resource.h>
#include <errno.h>
#include <stdlib.h>

#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <linux/filter.h>

#define BPF_FUNC_jiffies64 118

const int AVG_TRIES =3D 50;
const int MAX_ITERS =3D 6;
int verbose =3D 0;

static void stop(char* description) {
  fprintf(stderr, "%s: %s\n", description, strerror(errno));
  exit(1);
}

static struct bpf_insn *gen_prog(int size, int *real_size) {
  int i =3D 0;
  *real_size =3D size + 2;
  struct bpf_insn *prog =3D calloc(*real_size, sizeof(struct bpf_insn));

  if (!prog)
    stop("can't allocate prog");

  while (i < size)
    prog[i++] =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffie=
s64);

  prog[i++] =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
  prog[i++] =3D BPF_EXIT_INSN();

  return prog;
}

static int get_verif_time_usec(struct bpf_insn *prog, int real_prog_len) {
  LIBBPF_OPTS(bpf_prog_load_opts, opts);
  char log[4096];

  opts.log_level =3D verbose ? 1 | 4 : 4;
  opts.log_buf =3D log;
  opts.log_size =3D sizeof(log);
=20
  int prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT,
                              NULL, "GPL", prog, real_prog_len, &opts);
  log[sizeof(log)-1] =3D 0;

  if (verbose)
    printf("--- log start ---\n%s--- log end   ---\n", log);

  if (prog_fd < 0)
    stop("can't load prog");
 =20
  close(prog_fd);

  int verif_time_usec =3D 0;
  if (sscanf(log, "verification time %d usec", &verif_time_usec) !=3D 1)
    stop("can't get verification time from log");

  return verif_time_usec;
}

static int cmpint(const void *a, const void *b) {
  return *(int*)a - *(int*)b;
}

static int get_avg_verif_time_usec(int prog_len) {
  int results[AVG_TRIES];
  int real_prog_len;
  struct bpf_insn *prog =3D gen_prog(prog_len, &real_prog_len);
  for (int i =3D 0; i < AVG_TRIES; ++i) {
    results[i] =3D get_verif_time_usec(prog, real_prog_len);
  }
  free(prog);
  qsort(results, AVG_TRIES, sizeof(int), cmpint);
  int total_usec =3D 0;
  int samples_num =3D 0;
  for (int i =3D AVG_TRIES / 4; i < (3 * AVG_TRIES / 4); ++i) {
    total_usec +=3D results[i];
    samples_num +=3D 1;
  }
  return total_usec / samples_num;
}

int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_l=
ist args) {
  return vfprintf(stderr, format, args);
}

int main(int argc, char **argv) {
  libbpf_set_print(libbpf_print_fn);
  printf("%10s     %s\n", "prog len", "verif time usec");
  int prev_prog_len =3D -1;
  int prev_time =3D -1;
  for (int i =3D 0; i <=3D MAX_ITERS; ++i) {
    int prog_len =3D (1 << i) * 128;
    int avg_verif_time_usec =3D get_avg_verif_time_usec(prog_len);
    if (prev_prog_len >=3D 0)
      printf("%10d x%1.f %10d x%1.1f\n",
             prog_len,
             ((double)prog_len / prev_prog_len),
             avg_verif_time_usec,
             ((double)avg_verif_time_usec / prev_time));
    else
      printf("%10d    %10d\n", prog_len, avg_verif_time_usec);
    prev_prog_len =3D prog_len;
    prev_time =3D avg_verif_time_usec;
  }
  return 0;
}

