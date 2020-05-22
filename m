Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB751DE152
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgEVHxT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 03:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgEVHxR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 03:53:17 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4BC08C5C0
        for <bpf@vger.kernel.org>; Fri, 22 May 2020 00:53:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f3so10466351ioj.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2020 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hMIF0bX1Z2ctSQRsIH8bL7klvWMt1Ycgv5mMdX899A=;
        b=Gk2163dsjAuCNMV7LA/ZO42nMwxeZZ8nqJ1CBTIwgC8z9GLVnppYZnzstChQrm2qfD
         8mK9im+afdMDewIqO5+X0zY8inurUF6yBtXCr4le9dq07HdNqzliYP9linligez9q6A4
         vz5QgloIQQzgBn68xxitBfY7Z/LTbARHOfPzkJ85zkXpSMx997hIS9xwP2ZvNBtV0vlF
         vMWlbsnsL2vmVoJo2A+kURB5Z24W+eD7ovARCe+hLsKTyGNk6JMBNtxzJ3142utLLo4h
         XBZFh7Wpw3WPne/kbai3pyc0huvqfMtLzf7bZ/JqN7UuT379sgLl2mz4R8+evKeOPCON
         njuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hMIF0bX1Z2ctSQRsIH8bL7klvWMt1Ycgv5mMdX899A=;
        b=e1/YBF6BOrV4CRwqEizORhqnqvQ9MJQVTP3Z2+0nFHVoSCd0+IR0W4Avisnhg43fcC
         8+7NjRiI2GMEUYRPZ99G7soEucg3B7IkS4SR53EPwV0vWsgXSXy1RA8CD3N9LACpBPxx
         zUILrA8Ym8/jduSECqWvGzxRYb27J0kYys00+4hpOsLotcwWhYsn6kPizue66fSUMEWJ
         lrXVuexayCD0aNld9LcNfZHqEzs5nlFmGFvKc30qg/evFsk3s2Pbk9dzhNgCM5xn11fm
         QJaGcguRLk0fQ3XTT0+hFRUuG80PrEh/OHQQT855aLthV/7TMrN28XN4z3OnhUHMSveg
         uBYg==
X-Gm-Message-State: AOAM533nRf9uV2BSoMWXoeLMzcldb/ryPolUuPSg8FrVr6NMr7RKP0Ez
        I9/kpdsztt7abYR6TPNHxsYqwQZ/ifZrhstVTT6iPw==
X-Google-Smtp-Source: ABdhPJw8ie6elC0IvR64+rA0KFztqvvPkNu/yxHl9rVx5DEDKO3Y7o1i7gvscpCS/kn/kL6IVesi9lAsfGqChJXom24=
X-Received: by 2002:a5e:c603:: with SMTP id f3mr2039700iok.56.1590133995721;
 Fri, 22 May 2020 00:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200521123835.70069-1-songmuchun@bytedance.com> <20200521164746.GD28818@bombadil.infradead.org>
In-Reply-To: <20200521164746.GD28818@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 22 May 2020 15:52:39 +0800
Message-ID: <CAMZfGtWn4xa-5-0rN2KJzUYioiOOUYX9BFcUDNZS85H11sYDEA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] files: Use rcu lock to get the file
 structures for better performance
To:     Matthew Wilcox <willy@infradead.org>
Cc:     adobriyan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        ebiederm@xmission.com, bernd.edlinger@hotmail.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 22, 2020 at 12:47 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 21, 2020 at 08:38:35PM +0800, Muchun Song wrote:
> > +++ b/fs/proc/fd.c
> > @@ -34,19 +34,27 @@ static int seq_show(struct seq_file *m, void *v)
> >       if (files) {
> >               unsigned int fd = proc_fd(m->private);
> >
> > -             spin_lock(&files->file_lock);
> > +             rcu_read_lock();
> > +again:
> >               file = fcheck_files(files, fd);
> >               if (file) {
> > -                     struct fdtable *fdt = files_fdtable(files);
> > +                     struct fdtable *fdt;
> > +
> > +                     if (!get_file_rcu(file)) {
> > +                             /*
> > +                              * we loop to catch the new file (or NULL
> > +                              * pointer).
> > +                              */
> > +                             goto again;
> > +                     }
> >
> > +                     fdt = files_fdtable(files);
>
> This is unusual, and may not be safe.
>
> fcheck_files() loads files->fdt.  Then it loads file from fdt->fd[].
> Now you're loading files->fdt again here, and it could have been changed
> by another thread expanding the fd table.
>
> You have to write a changelog which convinces me you've thought about
> this race and that it's safe.  Because I don't think you even realise
> it's a possibility at this point.

Thanks for your review, it is a problem. I can fix it.

>
> > @@ -160,14 +168,23 @@ static int proc_fd_link(struct dentry *dentry, struct path *path)
> >               unsigned int fd = proc_fd(d_inode(dentry));
> >               struct file *fd_file;
> >
> > -             spin_lock(&files->file_lock);
> > +             rcu_read_lock();
> > +again:
> >               fd_file = fcheck_files(files, fd);
> >               if (fd_file) {
> > +                     if (!get_file_rcu(fd_file)) {
> > +                             /*
> > +                              * we loop to catch the new file
> > +                              * (or NULL pointer).
> > +                              */
> > +                             goto again;
> > +                     }
> >                       *path = fd_file->f_path;
> >                       path_get(&fd_file->f_path);
> > +                     fput(fd_file);
> >                       ret = 0;
> >               }
> > -             spin_unlock(&files->file_lock);
> > +             rcu_read_unlock();
>
> Why is it an improvement to increment/decrement the refcount on the
> struct file here, rather than take/release the spinlock?
>

lock-free vs spinlock.

Do you think spinlock would be better than the lock-free method?
Actually I prefer the rcu lock.

-- 
Yours,
Muchun
